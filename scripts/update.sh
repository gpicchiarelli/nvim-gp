#!/usr/bin/env zsh
set -euo pipefail

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

if command -v port >/dev/null 2>&1; then
  sudo port selfupdate
  sudo port upgrade outdated
fi

nvim --headless "+Lazy! sync" +qa
nvim --headless "+TSUpdateSync" +qa

print "Aggiornamento completato."
