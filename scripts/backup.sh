#!/usr/bin/env zsh
set -euo pipefail

SOURCE="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
DEST="$HOME/nvim-gp-backup-$(date +%Y%m%d-%H%M%S).tar.gz"

tar -czf "$DEST" -C "${SOURCE:h}" "${SOURCE:t}"
print "Backup creato: $DEST"
