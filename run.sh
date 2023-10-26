#!/usr/bin/env bash
#
# This program will run a bash script in a verbose sort of manner:
#   - read line by line
#   - print comments as dark gray
#   - if a non-comment line is found, store it in a variable
#   - continue reading lines and storing them until a blank line is found
#   - once a blank line is found, run the stored lines as a bash script
#   - repeat until the end of the file is reached

# set -x

# Get the script name from the first argument
SCRIPT_NAME="${1}"

# If a script name was not provided, print an error and exit
if [[ -z "${SCRIPT_NAME}" ]]; then
    echo "usage: $(basename "${0}") <script>"
    exit 1
fi

# ANSI escape codes
C_RESET="\033[0m"
C_DARK_GRAY="\033[1;30m"
C_BOLD="\033[1m"
C_GREEN="\033[0;32m"

# code buffer
CODE_BUFFER=()

# Define a function to print a line of text in dark gray
function print_comment() {
    printf "${C_DARK_GRAY}%s${C_RESET}\n" "${@}"
}

# Define a function to print code in green
function print_code() {
    printf "${C_GREEN}%s${C_RESET}\n" "${@}"
}

# Print the script name in bold
echo -e "${C_BOLD}${SCRIPT_NAME}${C_RESET}"

# Read the file line by line
let code_block_count=0
let line_num=0
while IFS= read -r line; do
    let line_num++

    # If the line is a comment, print it in dark gray
    if [[ "${line}" =~ ^[[:space:]]*("#".*) ]]; then
        print_comment "${BASH_REMATCH[1]}"
    # If the line is not a comment, store it in the buffer
    elif grep -qE '^[[:space:]]*[^#]' <<< "${line}"; then
        CODE_BUFFER+=("${line}")
    elif [[ -z "${line}" ]]; then
        # If the line is blank, and we have code in the buffer, run it
        if [[ ${#CODE_BUFFER[@]} -gt 0 ]]; then
            # Print the code
            print_code "${CODE_BUFFER[@]}"

            # Run the buffer as a bash script
            eval "$(printf "%s\n" "${CODE_BUFFER[@]}")" \
                | sed -e 's/^/> /'

            # Clear the buffer
            CODE_BUFFER=()

            # Increment the code block count
            let code_block_count++
        fi

        # Echo the blank line
        echo
    fi
done < "${SCRIPT_NAME}"
