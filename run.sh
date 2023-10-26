#!/usr/bin/env bash
#
# This program will run a bash script in a verbose sort of manner:
#   - read line by line
#   - print comments as dark gray
#   - if a non-comment line is found, store it in a variable
#   - continue reading lines and storing them until a blank line is found
#   - once a blank line is found, run the stored lines as a bash script
#   - repeat until the end of the file is reached

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

# Line buffer
BUFFER=""

# Define a function to print a line of text in dark gray
function print_comment() {
    echo -e "${C_DARK_GRAY}${@}${C_RESET}"
}

# Define a function to print code in green
function print_code() {
    echo -e "${C_GREEN}${@}${C_RESET}"
}

# Print the script name in bold
echo -e "${C_BOLD}${SCRIPT_NAME}${C_RESET}"

# Read the file line by line
let code_block_count=0
while IFS= read -r line; do
    # If the line is a comment, print it in dark gray
    if [[ "${line}" =~ ^[[:space:]]*("#".*) ]]; then
        print_comment "${BASH_REMATCH[1]}"
    # If the line is not a comment, store it in the buffer
    else
        BUFFER="${BUFFER}${line}\n"
    fi

    # If the line is blank, and we have code in the buffer, run it
    if [[ -z "${line}" && -n "${BUFFER}" ]]; then
        # If this is not the first code block, print a blank line
        if [[ ${code_block_count} -gt 0 ]]; then
            echo
        fi

        # Print the code
        print_code "${BUFFER}"

        # Run the buffer as a bash script
        eval "${BUFFER}"

        # Clear the buffer
        BUFFER=""

        # Increment the code block count
        let code_block_count++
    fi
done < "${1}"