$ErrorActionPreference = "Stop"

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    throw "winget non trovato. Installa App Installer da Microsoft Store o usa Windows 11 aggiornato."
}

Get-Content "$PSScriptRoot\..\winget-packages.txt" |
    Where-Object { $_ -and -not $_.StartsWith("#") } |
    ForEach-Object {
        winget install --id $_ --exact --accept-package-agreements --accept-source-agreements
    }

if (Get-Command cpanm -ErrorAction SilentlyContinue) {
    cpanm --notest Perl::LanguageServer App::perlimports Test2::V0 Perl::Tidy Perl::Critic Devel::NYTProf
}

Write-Host "Bootstrap Windows 11 completato."
