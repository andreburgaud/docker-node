#!/bin/bash

set -e

NODE_VERSION=$(node --version)

print_version() {
    echo -e "\e[92mNode.js version ${NODE_VERSION}\e[39m"
}

print_help() {
    echo -e "\e[93mUsage:\e[39m"
    echo -e "  \e[97mdocker run --rm -it andreburgaud/node [<options>] [<arguments]\e[39m: starts Node"
    echo -e "  \e[97mdocker run --rm -it andreburgaud/node [<command>] [<options>] [<arguments]:\e[39m"
    echo -e "  \e[93mCommands\e[39m"
    echo -e "    \e[97mshell [options] [arguments]\e[39m : starts a Node shell with rlwrap"
    echo    "                                 (with all harmony features enabled)"
    echo -e "    \e[97mbash\e[39m                        : starts a Bash shell"
    echo -e "    \e[97mhelp\e[39m                        : displays this help"
    echo -e "    \e[97mversion\e[39m                     : displays Node.js version"
}

start_node() {
    node $*
}

start_bash() {
    shift # Pop the command 'bash' out
    echo -e "\e[93mExecute 'entrypoint.sh help' to display the help\e[39m"
    exec bash
}

start_shell() {
    shift # Pop the command 'shell' out

    # Array of harmony options not enabled by default
    OPTIONS=$(node --v8-options \
    | grep -A1 "\-\-harmony" \
    | awk '/^  --harmony/ { l = $1; getline; printf "%s %s\n", l, $4}' \
    | grep false \
    | cut -d ' ' -f 1 \
    | tr "\n" " ")

    echo -e "\e[93mOptions\e[39m: ${OPTIONS[*]} $*"
    echo
    bash -c "sleep 0.5; NODE_NO_READLINE=1 rlwrap -m -pgreen node --experimental-repl-await ${OPTIONS[*]} $*"
}

# Main
if [ "$1" = 'bash' ]; then
    start_bash $@
elif [ "$1" = 'shell' ]; then
    start_shell $@
elif [ "$1" = 'version' ]; then
    print_version
elif [ "$1" = 'help' ]; then
    print_help
else
    start_node $@
fi
