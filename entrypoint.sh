#!/bin/bash

set -e

NODE_VERSION=$(node --version)

print_version() {
    echo -e "\e[92mNode.js version ${NODE_VERSION}\e[39m"
}

print_help() {
    echo -e "\e[93mUsage:\e[39m"
    echo -e "  \e[97mdocker run --rm -it andreburgaud/node [<options>] [<arguments]\e[39m: Node REPL"
    echo -e "  \e[97mdocker run --rm -it andreburgaud/node [<command>] [<options>] [<arguments]:\e[39m"
    echo -e "  \e[93mCommands\e[39m"
    echo -e "    \e[97mharmony\e[39m  : starts Node.js with all harmony flags on"
    echo -e "    \e[97mbash\e[39m     : starts Bash shell"
    echo -e "    \e[97mhelp\e[39m     : displays this help"
    echo -e "    \e[97mversion\e[39m  : displays Node.js version"
}

start_node_harmony() {
    shift # pop command 'harmony'

    OPTIONS=$(node --v8-options \
    | grep -A1 "\-\-harmony" \
    | awk '/^  --harmony/ { l = $1; getline; printf "%s %s\n", l, $4}' \
    | grep false \
    | cut -d ' ' -f 1)

    echo -e "\e[93mAll harmony options turned on, including:\e[39m"
    echo "${OPTIONS}"

    # Replace EOL with space
    OPTIONS=$(echo ${OPTIONS} | tr "\n" " ")

    echo
    node ${OPTIONS} $*
}

start_node() {
    node ${OPTIONS} $*
}

start_bash() {
    shift # Pop command 'bash'
    echo -e "\e[93mExecute 'entrypoint.sh help' to display the help\e[39m"
    exec bash
}

# Main
if [ "$1" = 'bash' ]; then
    start_bash $@
elif [ "$1" = 'version' ]; then
    print_version
elif [ "$1" = 'help' ]; then
    print_help
elif [ "$1" = 'harmony' ]; then
    start_node_harmony $@
else
    start_node $@
fi
