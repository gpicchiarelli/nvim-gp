#!/usr/bin/env sh
set -eu

"$(dirname -- "$0")/lint.sh"
"$(dirname -- "$0")/test.sh"
