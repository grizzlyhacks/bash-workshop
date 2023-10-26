# Contains helpful functions for the scripts in this repository

# @description Echo and run a command, returning its exit code
# @usage echo-run <command>
# @example echo-run ls -l
# @example echo-run "ls -l"
function echo-run() {
    local cmd=("${@}")
    local exit_code

    # echo the command...
    printf "\033[32m\u25b6 \033[1m%s\033[0m" "${cmd[0]}"
    # ...if there is more than one argument, print them
    if [[ ${#cmd[@]} -gt 1 ]]; then
        printf "\033[32m%s\033[0m" "$(printf " %q" "${cmd[@]:1}")"
    fi
    echo

    # if we only have one argument and it contains a space, run it with eval
    if [[ ${#cmd[@]} -eq 1 && "${cmd[0]}" =~ " " ]]; then
        cmd=(eval "${cmd[0]}")
    fi
    # run the command, prepending each line of output with a vertical bar
    "${cmd[@]}" 2>&1 | sed -e '$ ! s/^/\x1b[32m\xe2\x94\x82\x1b[0m / ; $ s/^/\x1b[32m\xe2\x95\xb0\x1b[0m /'
    exit_code=${PIPESTATUS[0]}

    # oh no errors
    if [[ ${exit_code} -ne 0 ]]; then
        echo -e "\033[31mcommand exited with status ${exit_code}\033[0m"
    fi

    # return its exit code
    return ${exit_code}
}
