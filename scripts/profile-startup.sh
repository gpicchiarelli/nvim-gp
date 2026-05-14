#!/usr/bin/env zsh
set -euo pipefail

LOG="${1:-startup.log}"
nvim --startuptime "$LOG" +qa
tail -40 "$LOG"
