#!/usr/bin/env zsh
set -euo pipefail

ROOT="${0:A:h:h}"
TARGET="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
STAMP="$(date +%Y%m%d-%H%M%S)"

if [[ -e "$TARGET" && ! -L "$TARGET" ]]; then
  mv "$TARGET" "$TARGET.backup.$STAMP"
fi

mkdir -p "${TARGET:h}"
ln -sfn "$ROOT" "$TARGET"

print "Configurazione installata: $TARGET -> $ROOT"
print "Avvia con: nvim"
