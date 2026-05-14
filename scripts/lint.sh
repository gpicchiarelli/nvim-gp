#!/usr/bin/env sh
set -eu

ROOT="$(CDPATH=; cd -- "$(dirname -- "$0")/.." && pwd)"
cd "$ROOT"

check_newlines() {
  failed=0
  tmp="$(mktemp)"
  find init.lua Makefile README.md AGENTS.md CONTRIBUTING.md SECURITY.md SUPPORT.md CHANGELOG.md lua after ftdetect snippets syntax scripts docs .github -type f \
    \( -name '*.lua' -o -name '*.vim' -o -name '*.sh' -o -name '*.ps1' -o -name '*.md' -o -name '*.yml' -o -name '*.yaml' -o -name 'Makefile' \) > "$tmp"
  while IFS= read -r file; do
    lines="$(wc -l < "$file" | tr -d ' ')"
    case "$file" in
      *.ps1|*.yml|*.yaml|*.md) min=1 ;;
      *) min=2 ;;
    esac
    if [ "$lines" -lt "$min" ]; then
      printf 'File sospetto, troppo compresso: %s (%s righe)\n' "$file" "$lines" >&2
      failed=1
    fi
    if [ -s "$file" ] && [ "$(tail -c 1 "$file" | wc -l | tr -d ' ')" -eq 0 ]; then
      printf 'File senza newline finale: %s\n' "$file" >&2
      failed=1
    fi
  done < "$tmp"
  rm -f "$tmp"
  return "$failed"
}

check_lua() {
  if command -v nvim >/dev/null 2>&1; then
    XDG_STATE_HOME="$ROOT/.state" \
    XDG_DATA_HOME="$ROOT/.data" \
    XDG_CACHE_HOME="$ROOT/.cache" \
    nvim --headless -u NONE \
      '+lua for _, f in ipairs(vim.fn.glob("**/*.lua", false, true)) do local ok, err = loadfile(f); if not ok then error(f .. ": " .. err) end end' \
      +qa
  fi
}

check_shell() {
  for script in scripts/*.sh; do
    shebang="$(head -n 1 "$script")"
    case "$shebang" in
      *zsh)
        if command -v zsh >/dev/null 2>&1; then
          zsh -n "$script"
        fi
        ;;
      *bash | *sh)
        if command -v shellcheck >/dev/null 2>&1; then
          shellcheck "$script"
        fi
        ;;
    esac
  done
}

check_powershell() {
  if command -v pwsh >/dev/null 2>&1; then
    for script in scripts/*.ps1; do
      pwsh -NoProfile -Command "\$null = [System.Management.Automation.Language.Parser]::ParseFile('$script', [ref]\$null, [ref]\$null)"
    done
  fi
}

check_newlines
check_lua
check_shell
check_powershell
git diff --check
rm -rf .state .data .cache
