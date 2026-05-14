#!/usr/bin/env zsh
set -euo pipefail

ROOT="${0:A:h:h}"
PORTS_FILE="$ROOT/ports.txt"
ASKPASS="$ROOT/scripts/macos-askpass.sh"

if [[ "$(uname -s)" != "Darwin" ]]; then
  print -u2 "Questo script e riservato a macOS con MacPorts."
  exit 1
fi

if [[ ! -x /opt/local/bin/port ]]; then
  print -u2 "MacPorts non trovato in /opt/local/bin/port."
  print -u2 "Installa MacPorts prima di proseguire: https://www.macports.org/install.php"
  exit 1
fi

if [[ ! -f "$PORTS_FILE" ]]; then
  print -u2 "Manifest MacPorts non trovato: $PORTS_FILE"
  exit 1
fi

if [[ ! -x "$ASKPASS" ]]; then
  print -u2 "Askpass GUI non eseguibile: $ASKPASS"
  print -u2 "Esegui: chmod +x $ASKPASS"
  exit 1
fi

export PATH="/opt/local/bin:/opt/local/sbin:/opt/local/lib/postgresql16/bin:/opt/local/lib/mariadb-11.4/bin:/opt/local/libexec/llvm-17/bin:$PATH"
export SUDO_ASKPASS="$ASKPASS"
export SUDO_ASKPASS_REQUIRE=prefer

autoload -Uz is-at-least

typeset -a missing_ports
typeset -a missing_cpan_modules
typeset -a manual_gates
typeset -a satisfied_gates
typeset -a failed_gates
missing_ports=()
missing_cpan_modules=()
manual_gates=()
satisfied_gates=()
failed_gates=()

sudo_gui() {
  SUDO_ASKPASS_PROMPT="Password amministratore per MacPorts / Nvim GP" sudo -A "$@"
}

add_port() {
  local port_name="$1"
  local existing

  for existing in "${missing_ports[@]}"; do
    [[ "$existing" == "$port_name" ]] && return
  done
  missing_ports+=("$port_name")
}

add_cpan_module() {
  local module_name="$1"
  local existing

  for existing in "${missing_cpan_modules[@]}"; do
    [[ "$existing" == "$module_name" ]] && return
  done
  missing_cpan_modules+=("$module_name")
}

normalize_version() {
  print -r -- "$1" | sed -E 's/^[^0-9]*//; s/[^0-9.].*$//'
}

command_version() {
  local command_name="$1"

  case "$command_name" in
    nvim) "$command_name" --version | sed -n '1s/^NVIM v//p' ;;
    git) "$command_name" --version | awk '{print $3}' ;;
    tmux) "$command_name" -V | awk '{print $2}' ;;
    perl) "$command_name" -e 'print $^V' ;;
    node) "$command_name" --version | sed 's/^v//' ;;
    php) "$command_name" -r 'echo PHP_VERSION;' ;;
    npm|cmake) "$command_name" --version | sed -n '1s/[^0-9]*//p' ;;
    *) "$command_name" --version 2>/dev/null | sed -n '1s/[^0-9]*//p' ;;
  esac | head -n 1
}

command_gate_ok() {
  local command_name="$1"
  local minimum_version="${2:-}"
  local actual_version
  local candidate

  if [[ "$command_name" == *,* ]]; then
    for candidate in ${(s:,:)command_name}; do
      command_gate_ok "$candidate" "$minimum_version" && return 0
    done
    return 1
  fi

  command -v "$command_name" >/dev/null 2>&1 || return 1
  [[ -z "$minimum_version" ]] && return 0

  actual_version="$(normalize_version "$(command_version "$command_name")")"
  [[ -n "$actual_version" ]] || return 1
  is-at-least "$minimum_version" "$actual_version"
}

perl_module_gate_ok() {
  local module_name="$1"

  command -v perl >/dev/null 2>&1 || return 1
  perl -M"$module_name" -e1 >/dev/null 2>&1
}

evaluate_gate() {
  local label="$1"
  local kind="$2"
  local probe="$3"
  local minimum_version="$4"
  local ports_csv="$5"
  local cpan_module="${6:-}"
  local ok=1
  local port_name

  case "$kind" in
    command) command_gate_ok "$probe" "$minimum_version" && ok=0 ;;
    perl_module) perl_module_gate_ok "$probe" && ok=0 ;;
    *) print -u2 "Gate non riconosciuto: $label ($kind)"; return 1 ;;
  esac

  if (( ok == 0 )); then
    satisfied_gates+=("$label")
    return
  fi

  failed_gates+=("$label")
  if [[ "$kind" == "perl_module" ]] && command_gate_ok perl 5.38 && command -v cpanm >/dev/null 2>&1; then
    add_cpan_module "${cpan_module:-$probe}"
    return
  fi

  if [[ -z "$ports_csv" ]]; then
    manual_gates+=("$label")
    return
  fi

  for port_name in ${(s:,:)ports_csv}; do
    [[ -n "$port_name" ]] && add_port "$port_name"
  done
}

typeset -a gates
gates=(
  "Neovim|command|nvim|0.10|neovim"
  "Git|command|git|2.39|git"
  "ripgrep|command|rg||ripgrep"
  "fd|command|fd||fd"
  "tmux|command|tmux|3.3|tmux"
  "ctags|command|ctags||universal-ctags"
  "jq|command|jq||jq"
  "shellcheck|command|shellcheck||shellcheck"
  "shfmt|command|shfmt||shfmt"
  "marksman|command|marksman||marksman"
  "tree-sitter CLI|command|tree-sitter||tree-sitter-cli"
  "Lua language server|command|lua-language-server||lua-language-server"
  "clangd|command|clangd||clang-tools-extra-17"
  "lldb|command|lldb||lldb-17"
  "cmake|command|cmake|3.25|cmake"
  "ninja|command|ninja||ninja"
  "PostgreSQL client|command|psql||postgresql16"
  "MariaDB client|command|mariadb,mysql||mariadb-11.4"
  "SQLite|command|sqlite3||sqlite3"
  "FreeTDS|command|tsql||freetds"
  "Perl|command|perl|5.38|perl5.38"
  "cpanm|command|cpanm||p5.38-app-cpanminus"
  "carton|command|carton||p5.38-carton"
  "perlcritic|command|perlcritic||p5.38-perl-critic"
  "perltidy|command|perltidy||p5.38-perl-tidy"
  "prove|command|prove||perl5.38"
  "podchecker|command|podchecker||p5.38-pod-simple"
  "Perl::LanguageServer|perl_module|Perl::LanguageServer||p5.38-perl-language-server|Perl::LanguageServer"
  "Test2::V0|perl_module|Test2::V0||p5.38-test2-suite|Test2::V0"
  "Devel::NYTProf|perl_module|Devel::NYTProf||p5.38-devel-nytprof|Devel::NYTProf"
  "App::perlimports|perl_module|App::perlimports||p5.38-app-perlimports|App::perlimports"
  "PHP|command|php,php83|8.2|php83"
  "Composer|command|composer||"
  "Node.js|command|node|20|nodejs20"
  "npm|command|npm|10|npm10"
  "Swift formatter|command|swift-format,swiftformat||swiftformat"
)

print "MacPorts manifest: $PORTS_FILE"
print "Modalita: gate ragionati. Un tool sufficiente gia presente non viene installato via MacPorts."

local_gate=""
for local_gate in "${gates[@]}"; do
  IFS='|' read -r label kind probe minimum ports_csv cpan_module <<< "$local_gate"
  evaluate_gate "$label" "$kind" "$probe" "$minimum" "$ports_csv" "$cpan_module"
done

print ""
print "Gate soddisfatti:"
if (( ${#satisfied_gates[@]} )); then
  printf ' ok  %s\n' "${satisfied_gates[@]}"
else
  print " nessuno"
fi

if (( ${#failed_gates[@]} )); then
  print ""
  print "Gate da correggere:"
  printf ' add %s\n' "${failed_gates[@]}"
fi

if (( ${#missing_ports[@]} )); then
  print ""
  print "Port richiesti dai gate falliti:"
  printf ' - %s\n' "${missing_ports[@]}"
  if [[ "${NVIM_GP_DRY_RUN:-0}" == "1" ]]; then
    print "Dry-run attivo: installazione MacPorts saltata."
  else
    sudo_gui /opt/local/bin/port selfupdate
    sudo_gui /opt/local/bin/port install "${missing_ports[@]}"
  fi
else
  print ""
  print "Nessun port MacPorts richiesto dai gate installabili."
fi

if (( ${#manual_gates[@]} )); then
  print ""
  print "Gate senza port MacPorts stabile:"
  printf ' manual %s\n' "${manual_gates[@]}"
fi

if (( ${#missing_cpan_modules[@]} )); then
  print ""
  print "Moduli CPAN richiesti dal Perl corrente:"
  printf ' - %s\n' "${missing_cpan_modules[@]}"
  if [[ "${NVIM_GP_DRY_RUN:-0}" == "1" ]]; then
    print "Dry-run attivo: installazione CPAN saltata."
  else
    cpanm --notest "${missing_cpan_modules[@]}"
  fi
fi

if [[ "${NVIM_GP_MACPORTS_UPGRADE:-0}" == "1" && "${NVIM_GP_DRY_RUN:-0}" != "1" ]]; then
  sudo_gui /opt/local/bin/port upgrade outdated
fi

if [[ "${NVIM_GP_DRY_RUN:-0}" != "1" ]] && /opt/local/bin/port select --summary 2>/dev/null | grep -q '^php '; then
  sudo_gui /opt/local/bin/port select --set php php83 || true
fi

if [[ "${NVIM_GP_DRY_RUN:-0}" != "1" ]] && /opt/local/bin/port select --summary 2>/dev/null | grep -q '^postgresql '; then
  sudo_gui /opt/local/bin/port select --set postgresql postgresql16 || true
fi

if [[ "${NVIM_GP_DRY_RUN:-0}" != "1" ]] && /opt/local/bin/port select --summary 2>/dev/null | grep -q '^llvm '; then
  sudo_gui /opt/local/bin/port select --set llvm mp-llvm-17 || true
fi

print ""
print "Verifica binari principali:"
for bin in nvim git rg fd tmux perl perlcritic perltidy prove carton cpanm podchecker psql clangd lldb cmake ninja php composer node npm tree-sitter; do
  if command -v "$bin" >/dev/null 2>&1; then
    printf ' ok  %s -> %s\n' "$bin" "$(command -v "$bin")"
  else
    printf ' warn %s non trovato nel PATH\n' "$bin"
  fi
done

print ""
print "Esegui ora: make health"
