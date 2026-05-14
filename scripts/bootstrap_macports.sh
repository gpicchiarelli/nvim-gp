#!/usr/bin/env zsh
set -euo pipefail

if [[ ! -x /opt/local/bin/port ]]; then
  print -u2 "MacPorts non trovato in /opt/local/bin/port."
  print -u2 "Installa MacPorts per macOS Apple Silicon e rilancia questo script."
  exit 1
fi

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

sudo port selfupdate
sudo port upgrade outdated

while IFS= read -r pkg; do
  [[ -z "$pkg" || "$pkg" == \#* ]] && continue
  sudo port install "$pkg"
done < ports.txt

print "Bootstrap MacPorts completato."
