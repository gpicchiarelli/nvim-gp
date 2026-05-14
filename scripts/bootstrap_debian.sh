#!/usr/bin/env bash
set -euo pipefail

if ! command -v apt-get >/dev/null 2>&1; then
  echo "Questo bootstrap richiede Debian o una derivata apt-based." >&2
  exit 1
fi

sudo apt-get update
sudo apt-get install -y $(grep -Ev '^\s*(#|$)' apt-packages.txt)

if command -v cpanm >/dev/null 2>&1; then
  cpanm --notest Perl::LanguageServer App::perlimports Test2::V0 Perl::Tidy Perl::Critic Devel::NYTProf
fi

echo "Bootstrap Debian completato."
