#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH=; cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT"

if command -v stylua >/dev/null 2>&1; then
  stylua init.lua lua after ftdetect snippets
fi

if command -v shfmt >/dev/null 2>&1; then
  shfmt -w scripts/*.sh
fi

if command -v perltidy >/dev/null 2>&1; then
  find . -type f \( -name '*.pl' -o -name '*.pm' -o -name '*.t' \) -not -path './.git/*' -print |
  while IFS= read -r file; do
    perltidy -b "$file"
    rm -f "$file.bak"
  done
fi
