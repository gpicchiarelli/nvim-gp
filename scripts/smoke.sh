#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH=; cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT"

XDG_STATE_HOME="$ROOT/.state" \
XDG_DATA_HOME="$ROOT/.data" \
XDG_CACHE_HOME="$ROOT/.cache" \
NVIM_GP_PHASE0=1 \
nvim --headless --cmd 'set rtp+=.' -u init.lua '+lua vim.notify("Nvim GP phase 0 smoke OK")' +qa

XDG_STATE_HOME="$ROOT/.state" \
XDG_DATA_HOME="$ROOT/.data" \
XDG_CACHE_HOME="$ROOT/.cache" \
nvim --headless -u NONE '+set rtp+=.' \
  '+lua local t = require("utils.telemetry"); assert(not t.status_safe("x<y> 100%"):find("[<>]")); assert(t.status_safe("100%"):find("%%%%"))' \
  +qa

rm -rf .state .data .cache
