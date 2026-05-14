$ErrorActionPreference = "Stop"

nvim --headless "+Lazy! sync" +qa
nvim --headless "+TSUpdateSync" +qa

Write-Host "Aggiornamento Neovim completato."
