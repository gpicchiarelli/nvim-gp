#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH=; cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT"

XDG_STATE_HOME="$ROOT/.state" \
XDG_DATA_HOME="$ROOT/.data" \
XDG_CACHE_HOME="$ROOT/.cache" \
NVIM_GP_PHASE0=1 \
nvim --headless --cmd 'set rtp+=.' -u init.lua \
  '+lua local ok, err = pcall(dofile, "tests/test_core.lua"); if not ok then print(err); vim.cmd("cquit") end' \
  +qa

XDG_STATE_HOME="$ROOT/.state" \
XDG_DATA_HOME="$ROOT/.data" \
XDG_CACHE_HOME="$ROOT/.cache" \
nvim --headless -u NONE \
  '+set rtp+=.' \
  '+lua local ok, err = pcall(dofile, "tests/test_modules.lua"); if not ok then print(err); vim.cmd("cquit") end' \
  +qa

XDG_STATE_HOME="$ROOT/.state" \
XDG_DATA_HOME="$ROOT/.data" \
XDG_CACHE_HOME="$ROOT/.cache" \
NVIM_GP_PHASE0=1 \
nvim --headless --cmd 'set rtp+=.' -u init.lua \
  '+lua local ok, err = pcall(dofile, "tests/test_feature_matrix.lua"); if not ok then print(err); vim.cmd("cquit") end' \
  +qa

rm -rf .state .data .cache
