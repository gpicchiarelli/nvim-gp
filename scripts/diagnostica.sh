#!/usr/bin/env zsh
set -euo pipefail

print "== Sistema =="
sw_vers
uname -m

print "\n== PATH =="
print "$PATH"

print "\n== MacPorts =="
port version || true
port installed neovim perl5.38 p5.38-perl-language-server postgresql16 clang-17 lldb-17 || true

print "\n== Perl =="
perl -V:version -V:archname -V:installsitebin
perl -MPerl::LanguageServer -e 'print "Perl::LanguageServer OK\n"' || true
perlcritic --version || true
perltidy --version || true

print "\n== Neovim =="
nvim --version | sed -n '1,12p'

print "\n== Lazy health =="
nvim --headless "+Lazy health" +qa || true
