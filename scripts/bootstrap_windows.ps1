$ErrorActionPreference = "Stop"

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "winget non trovato. Installa App Installer da Microsoft Store o usa Windows 11 aggiornato."
}

$missingPackages = New-Object System.Collections.Generic.List[string]
$satisfiedGates = New-Object System.Collections.Generic.List[string]
$failedGates = New-Object System.Collections.Generic.List[string]

function Add-Package {
    param([string] $PackageId)

    if (-not $PackageId) {
        return
    }
    if (-not $missingPackages.Contains($PackageId)) {
        $missingPackages.Add($PackageId)
    }
}

function Normalize-Version {
    param([string] $Value)

    if (-not $Value) {
        return ""
    }
    return ($Value -replace "^[^0-9]*", "" -replace "[^0-9.].*$", "")
}

function Test-VersionAtLeast {
    param(
        [string] $Actual,
        [string] $Minimum
    )

    if (-not $Minimum) {
        return $true
    }
    $actualClean = Normalize-Version $Actual
    if (-not $actualClean) {
        return $false
    }
    try {
        return ([version] $actualClean) -ge ([version] $Minimum)
    }
    catch {
        return $false
    }
}

function Get-CommandVersion {
    param([string] $CommandName)

    switch ($CommandName) {
        "nvim" { return ((& $CommandName --version)[0] -replace "^NVIM v", "") }
        "git" { return ((& $CommandName --version) -replace "^git version ", "") }
        "perl" { return (& $CommandName -e "print `$^V") }
        "node" { return ((& $CommandName --version) -replace "^v", "") }
        "php" { return (& $CommandName -r "echo PHP_VERSION;") }
        default { return ((& $CommandName --version 2>$null)[0]) }
    }
}

function Test-CommandGate {
    param(
        [string] $CommandName,
        [string] $MinimumVersion
    )

    if (-not (Get-Command $CommandName -ErrorAction SilentlyContinue)) {
        return $false
    }
    if (-not $MinimumVersion) {
        return $true
    }
    return Test-VersionAtLeast (Get-CommandVersion $CommandName) $MinimumVersion
}

function Test-PerlModuleGate {
    param([string] $ModuleName)

    if (-not (Get-Command perl -ErrorAction SilentlyContinue)) {
        return $false
    }
    & perl "-M$ModuleName" -e1 *> $null
    return $LASTEXITCODE -eq 0
}

function Test-Gate {
    param(
        [string] $Label,
        [string] $Kind,
        [string] $Probe,
        [string] $MinimumVersion,
        [string] $PackagesCsv
    )

    $ok = $false
    switch ($Kind) {
        "command" { $ok = Test-CommandGate $Probe $MinimumVersion }
        "perl_module" { $ok = Test-PerlModuleGate $Probe }
        default { throw "Gate non riconosciuto: $Label ($Kind)" }
    }

    if ($ok) {
        $satisfiedGates.Add($Label)
        return
    }

    $failedGates.Add($Label)
    $PackagesCsv.Split(",") | ForEach-Object { Add-Package $_.Trim() }
}

$gates = @(
    "Neovim|command|nvim|0.10|Neovim.Neovim",
    "Git|command|git|2.39|Git.Git",
    "ripgrep|command|rg||BurntSushi.ripgrep.MSVC",
    "fd|command|fd||sharkdp.fd",
    "Node.js|command|node|20|OpenJS.NodeJS.LTS",
    "cmake|command|cmake|3.25|Kitware.CMake",
    "ninja|command|ninja||Ninja-build.Ninja",
    "clangd|command|clangd||LLVM.LLVM",
    "lldb|command|lldb||LLVM.LLVM",
    "PostgreSQL client|command|psql||PostgreSQL.PostgreSQL",
    "MariaDB client|command|mariadb||MariaDB.Server",
    "SQLite|command|sqlite3||SQLite.SQLite",
    "Perl|command|perl|5.38|Perl.StrawberryPerl",
    "PHP|command|php|8.2|PHP.PHP",
    "Composer|command|composer||Composer.Composer",
    "PowerShell|command|pwsh|7|Microsoft.PowerShell",
    "shellcheck|command|shellcheck||koalaman.shellcheck",
    "cpanm|command|cpanm||Perl.StrawberryPerl",
    "Perl::Critic|perl_module|Perl::Critic||Perl.StrawberryPerl",
    "Perl::Tidy|perl_module|Perl::Tidy||Perl.StrawberryPerl",
    "Test2::V0|perl_module|Test2::V0||Perl.StrawberryPerl",
    "Devel::NYTProf|perl_module|Devel::NYTProf||Perl.StrawberryPerl"
)

Write-Host "Modalita: gate ragionati. Un tool sufficiente gia presente non viene installato via winget."

foreach ($gate in $gates) {
    $parts = $gate.Split("|")
    Test-Gate $parts[0] $parts[1] $parts[2] $parts[3] $parts[4]
}

Write-Host ""
Write-Host "Gate soddisfatti:"
if ($satisfiedGates.Count -gt 0) {
    $satisfiedGates | ForEach-Object { Write-Host " ok  $_" }
}
else {
    Write-Host " nessuno"
}

if ($failedGates.Count -gt 0) {
    Write-Host ""
    Write-Host "Gate da correggere:"
    $failedGates | ForEach-Object { Write-Host " add $_" }
}

if ($missingPackages.Count -gt 0) {
    Write-Host ""
    Write-Host "Pacchetti richiesti dai gate falliti:"
    $missingPackages | ForEach-Object { Write-Host " - $_" }
    if ($env:NVIM_GP_DRY_RUN -eq "1") {
        Write-Host "Dry-run attivo: installazione winget saltata."
    }
    else {
        foreach ($package in $missingPackages) {
            winget install --id $package --exact --accept-package-agreements --accept-source-agreements
        }
    }
}
else {
    Write-Host ""
    Write-Host "Tutti i gate risultano soddisfatti. Nessun pacchetto winget installato."
}

if (($env:NVIM_GP_DRY_RUN -ne "1") -and (Get-Command cpanm -ErrorAction SilentlyContinue)) {
    & perl -MPerl::LanguageServer -e1 *> $null
    if ($LASTEXITCODE -ne 0) { cpanm --notest Perl::LanguageServer }
    & perl -MApp::perlimports -e1 *> $null
    if ($LASTEXITCODE -ne 0) { cpanm --notest App::perlimports }
}

Write-Host "Bootstrap Windows 11 completato."
