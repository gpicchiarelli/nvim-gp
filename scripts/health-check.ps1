$ErrorActionPreference = "Stop"

$required = @(
    "nvim", "git", "rg", "fd", "perl", "perlcritic", "perltidy",
    "prove", "carton", "cpanm", "podchecker", "psql", "clangd",
    "lldb-vscode", "php", "composer", "node", "npm", "pwsh"
)

$missing = @()
foreach ($bin in $required) {
    if (-not (Get-Command $bin -ErrorAction SilentlyContinue)) {
        $missing += $bin
    }
}

if ($missing.Count -gt 0) {
    Write-Host "Strumenti mancanti:"
    $missing | ForEach-Object { Write-Host " - $_" }
    exit 1
}

nvim --headless "+checkhealth" +qa
Write-Host "Health-check Windows completato."
