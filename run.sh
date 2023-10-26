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

# Settings
BLANK_LINE_DELIMITERS=1 # number of blank lines to separate code block

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
    local colorizer=("cat")
    local start_color="${C_GREEN}" end_color="${C_RESET}"
    # Check if bash highlighting is available
    if command -v source-highlight &> /dev/null; then
        colorizer=("source-highlight" "--failsafe" "-f" "esc" "-s" "bash")
        start_color="" end_color=""
    elif command -v highlight &> /dev/null; then
        colorizer=("highlight" "-O" "ansi" "-S" "bash")
        start_color="" end_color=""
    elif command -v pygmentize &> /dev/null; then
        colorizer=("pygmentize" "-f" "terminal256" "-O" "style=monokai")q
        start_color="" end_color=""
    fi
    printf "${start_color}%s${end_color}\n" "${@}" \
        | "${colorizer[@]}" \
        | sed -e 's/^/> /'
}

# Print the script name in bold
echo -e "${C_BOLD}${SCRIPT_NAME}${C_RESET}"

# Read the file line by line
let code_block_count=0
let line_num=0
let blank_line_count=0
while IFS= read -r line; do
    let line_num++

    # Check if the line is blank
    is_blank=false
    if echo "${line}" | grep -qE '^[[:space:]]*$'; then
        # If the line is blank, increment the blank line count
        let blank_line_count++
        is_blank=true
    else
        # If the line is not blank, reset the blank line count
        blank_line_count=0
    fi

    if [[ "${line}" =~ ^[[:space:]]*"#" && ${#CODE_BUFFER[@]} -eq 0 ]]; then
        # If the line is a comment, and we're not in a code block, print it
        print_comment "${line}"
    elif ! ${is_blank}; then
        # If the line is not a blank line, store it in the code buffer
        CODE_BUFFER+=("${line}")
    elif [[ -z "${line}" ]]; then
        if [[
            ${#CODE_BUFFER[@]} -gt 0
            && ${blank_line_count} -ge ${BLANK_LINE_DELIMITERS}
        ]]; then
            # Print the code
            print_code "${CODE_BUFFER[@]}"

            # Run the buffer as a bash script
            eval "$(printf "%s\n" "${CODE_BUFFER[@]}")"

            # Clear the buffer
            CODE_BUFFER=()

            # Increment the code block count
            let code_block_count++
        fi

        # Echo the blank line
        echo
    fi
done < "${SCRIPT_NAME}"

# If we have code left in the buffer, print and run it
if [[ ${#CODE_BUFFER[@]} -gt 0 ]]; then
    # Print the code
    print_code "${CODE_BUFFER[@]}"

    # Run the buffer as a bash script
    eval "$(printf "%s\n" "${CODE_BUFFER[@]}")"

    # Clear the buffer
    CODE_BUFFER=()

    # Increment the code block count
    let code_block_count++
fi
