#!/usr/bin/env sh
set -eu

prompt="${SUDO_ASKPASS_PROMPT:-Password amministratore per Nvim GP}"

osascript <<OSA
set dialogText to "$prompt"
display dialog dialogText default answer "" with hidden answer buttons {"Annulla", "OK"} default button "OK" with title "Nvim GP"
text returned of result
OSA
