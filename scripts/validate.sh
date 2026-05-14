#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT"

if command -v nvim >/dev/null 2>&1; then
  XDG_STATE_HOME="$ROOT/.state" \
  XDG_DATA_HOME="$ROOT/.data" \
  XDG_CACHE_HOME="$ROOT/.cache" \
  nvim --headless -u NONE \
    '+lua for _, f in ipairs(vim.fn.glob("**/*.lua", false, true)) do local ok, err = loadfile(f); if not ok then error(f .. ": " .. err) end end' \
    +qa
fi

if command -v shellcheck >/dev/null 2>&1; then
  shellcheck scripts/*.sh
fi

git diff --check

rm -rf .state .data .cache
