#!/usr/bin/env bash
set -euo pipefail

if ! command -v apt-get >/dev/null 2>&1; then
  echo "Questo bootstrap richiede Debian o una derivata apt-based." >&2
  exit 1
fi

missing_packages=()
satisfied_gates=()
failed_gates=()

add_package() {
  local package_name="$1"
  local existing

  for existing in "${missing_packages[@]}"; do
    [[ "$existing" == "$package_name" ]] && return
  done
  missing_packages+=("$package_name")
}

version_ge() {
  local actual="$1"
  local minimum="$2"

  [[ -z "$minimum" ]] && return 0
  [[ -n "$actual" ]] || return 1
  [[ "$(printf '%s\n%s\n' "$minimum" "$actual" | sort -V | head -n 1)" == "$minimum" ]]
}

normalize_version() {
  sed -E 's/^[^0-9]*//; s/[^0-9.].*$//' <<<"$1"
}

command_version() {
  local command_name="$1"

  case "$command_name" in
    nvim) "$command_name" --version | sed -n '1s/^NVIM v//p' ;;
    git) "$command_name" --version | awk '{print $3}' ;;
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

  command -v "$command_name" >/dev/null 2>&1 || return 1
  [[ -z "$minimum_version" ]] && return 0

  actual_version="$(normalize_version "$(command_version "$command_name")")"
  version_ge "$actual_version" "$minimum_version"
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
  local packages_csv="$5"
  local ok=1
  local package_name

  case "$kind" in
    command) command_gate_ok "$probe" "$minimum_version" && ok=0 ;;
    perl_module) perl_module_gate_ok "$probe" && ok=0 ;;
    *) echo "Gate non riconosciuto: $label ($kind)" >&2; return 1 ;;
  esac

  if (( ok == 0 )); then
    satisfied_gates+=("$label")
    return
  fi

  failed_gates+=("$label")
  IFS=',' read -ra packages <<<"$packages_csv"
  for package_name in "${packages[@]}"; do
    [[ -n "$package_name" ]] && add_package "$package_name"
  done
}

gates=(
  "Neovim|command|nvim|0.10|neovim"
  "Git|command|git|2.39|git"
  "ripgrep|command|rg||ripgrep"
  "fd|command|fd||fd-find"
  "tmux|command|tmux|3.3|tmux"
  "ctags|command|ctags||universal-ctags"
  "jq|command|jq||jq"
  "curl|command|curl||curl"
  "shellcheck|command|shellcheck||shellcheck"
  "shfmt|command|shfmt||shfmt"
  "cmake|command|cmake|3.25|cmake"
  "ninja|command|ninja||ninja-build"
  "clangd|command|clangd||clangd"
  "clang-format|command|clang-format||clang-format"
  "lldb|command|lldb||lldb"
  "PostgreSQL client|command|psql||postgresql-client"
  "MariaDB client|command|mariadb||mariadb-client"
  "SQLite|command|sqlite3||sqlite3"
  "FreeTDS|command|tsql||freetds-bin"
  "Perl|command|perl|5.36|perl"
  "cpanm|command|cpanm||cpanminus"
  "carton|command|carton||carton"
  "perlcritic|command|perlcritic||perlcritic,libperl-critic-perl"
  "perltidy|command|perltidy||perltidy"
  "prove|command|prove||perl"
  "Perl::Critic|perl_module|Perl::Critic||libperl-critic-perl"
  "Devel::NYTProf|perl_module|Devel::NYTProf||libdevel-nytprof-perl"
  "Pod::Simple|perl_module|Pod::Simple||libpod-simple-perl"
  "Test2::V0|perl_module|Test2::V0||libtest2-suite-perl"
  "PHP|command|php|8.2|php-cli"
  "Composer|command|composer||composer"
  "Node.js|command|node|18|nodejs"
  "npm|command|npm||npm"
  "CLIPS|command|clips||clips"
)

echo "Modalita: gate ragionati. Un tool sufficiente gia presente non viene installato via apt."

for gate in "${gates[@]}"; do
  IFS='|' read -r label kind probe minimum packages_csv <<<"$gate"
  evaluate_gate "$label" "$kind" "$probe" "$minimum" "$packages_csv"
done

echo ""
echo "Gate soddisfatti:"
if ((${#satisfied_gates[@]})); then
  printf ' ok  %s\n' "${satisfied_gates[@]}"
else
  echo " nessuno"
fi

if ((${#failed_gates[@]})); then
  echo ""
  echo "Gate da correggere:"
  printf ' add %s\n' "${failed_gates[@]}"
fi

if ((${#missing_packages[@]})); then
  echo ""
  echo "Pacchetti richiesti dai gate falliti:"
  printf ' - %s\n' "${missing_packages[@]}"
  if [[ "${NVIM_GP_DRY_RUN:-0}" == "1" ]]; then
    echo "Dry-run attivo: installazione apt saltata."
  else
    sudo apt-get update
    sudo apt-get install -y "${missing_packages[@]}"
  fi
else
  echo ""
  echo "Tutti i gate risultano soddisfatti. Nessun pacchetto apt installato."
fi

if [[ "${NVIM_GP_DRY_RUN:-0}" != "1" ]] && command -v cpanm >/dev/null 2>&1; then
  perl -MPerl::LanguageServer -e1 >/dev/null 2>&1 || cpanm --notest Perl::LanguageServer
  perl -MApp::perlimports -e1 >/dev/null 2>&1 || cpanm --notest App::perlimports
fi

echo "Bootstrap Debian completato."
