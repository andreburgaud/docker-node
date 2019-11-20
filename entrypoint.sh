#!/bin/bash

set -e

# Array of harmony options not enabled by default
OPTIONS=$(node --v8-options \
| grep -A1 "\-\-harmony" \
| awk '/^  --harmony/ { l = $1; getline; printf "%s %s\n", l, $4}' \
| grep false \
| cut -d ' ' -f 1 \
| tr "\n" " ")

bash -c "sleep 0.5; NODE_NO_READLINE=1 rlwrap -m -pgreen node --experimental-repl-await ${OPTIONS[*]} $*"
