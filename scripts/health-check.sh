#!/usr/bin/env zsh
set -euo pipefail

required=(
  nvim git rg perl perlcritic perltidy prove carton cpanm
  podchecker psql clangd lldb cmake ninja php composer node npm
)

case "$(uname -s)" in
  Darwin)
    required+=(port tmux fd)
    ;;
  Linux)
    required+=(tmux)
    if command -v fdfind >/dev/null 2>&1; then
      required+=(fdfind)
    else
      required+=(fd)
    fi
    ;;
  *)
    required+=(fd)
    ;;
esac

missing=()
for bin in "${required[@]}"; do
  if ! command -v "$bin" >/dev/null 2>&1; then
    missing+=("$bin")
  fi
done

if (( ${#missing[@]} )); then
  print "Strumenti mancanti:"
  printf ' - %s\n' "${missing[@]}"
  exit 1
fi

nvim --headless "+checkhealth" +qa
print "Health-check completato."
