$ErrorActionPreference = "Stop"

$root = Resolve-Path "$PSScriptRoot\.."
$target = Join-Path $env:LOCALAPPDATA "nvim"
$stamp = Get-Date -Format "yyyyMMdd-HHmmss"

if (Test-Path $target) {
    $backup = "$target.backup.$stamp"
    Move-Item $target $backup
}

New-Item -ItemType Directory -Force -Path (Split-Path $target) | Out-Null
try {
    New-Item -ItemType SymbolicLink -Path $target -Target $root | Out-Null
}
catch {
    New-Item -ItemType Junction -Path $target -Target $root | Out-Null
}

Write-Host "Configurazione installata: $target -> $root"
Write-Host "Avvia con: nvim"
