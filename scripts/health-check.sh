#!/usr/bin/env zsh
set -euo pipefail

if [[ -f "${0:A:h}/macports-env.sh" ]]; then
  # shellcheck disable=SC1091
  source "${0:A:h}/macports-env.sh"
fi

required=(
  nvim git rg perl perlcritic perltidy prove carton cpanm
  podchecker psql clangd lldb cmake ninja php node npm tree-sitter
)

optional=(
  composer swiftformat
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
  print "Strumenti obbligatori mancanti:"
  printf ' - %s\n' "${missing[@]}"
  exit 1
fi

optional_missing=()
for bin in "${optional[@]}"; do
  if ! command -v "$bin" >/dev/null 2>&1; then
    optional_missing+=("$bin")
  fi
done

if (( ${#optional_missing[@]} )); then
  print "Strumenti opzionali mancanti:"
  printf ' - %s\n' "${optional_missing[@]}"
fi

health_state="${TMPDIR:-/tmp}/nvim-gp-health-state-$$"
health_cache="${TMPDIR:-/tmp}/nvim-gp-health-cache-$$"
mkdir -p "$health_state" "$health_cache"

XDG_STATE_HOME="$health_state" \
XDG_CACHE_HOME="$health_cache" \
nvim --headless "+checkhealth" +qa

rm -rf "$health_state" "$health_cache"
print "Health-check completato."
