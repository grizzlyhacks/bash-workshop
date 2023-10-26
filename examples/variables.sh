#!/usr/bin/env bash
#
# This script demonstrates how to declare variables in bash.

## Assigning Values ############################################################
################################################################################

# Variables are created by assigning a value to a name. There are a few
# different syntaxes for this:
# 1. <name>=<value>
#   Note there cannot be spaces around the equals sign, and the value cannot
#   have spaces in it.
organization=GrizzlyHacks
echo "organization = ${organization}"

# 2. <name>="<value>"
#   This syntax allows you to use spaces in the value.
school="Georgia Gwinnet College"
echo "school = ${school}"


# 3. let <name>=<value> <name2>=<value2> ...
#   This syntax ONLY works for integers but allows you to declare multiple
#   variables at once and use math operators.
let a=1 b=2 c="a + b"
echo "a = ${a}, b = ${b}, c = ${c}"


## Setting a variable to the output of a command
#
# You can set a variable to the output of a command by wrapping the command in
# $(). This is called "command substitution".
# Note that the command will be run when the variable is declared, not when it
# is used.
echo
echo "## Command Substitution ##"

# This will print the current date inside the string:
echo "The current date is $(date)."

# The following two lines will produce the same output by setting the variable
# `cur_date` to the output of the `date` command.
cur_date=$(date)
echo "The current date is ${cur_date}."


## Referencing variables #######################################################
################################################################################

filename="blah.tar"

# Variables can be referenced in one of two ways:
# 1. $name
#   This is the most common syntax and is used to reference a variable's value.
echo "filename = $filename"

# 2. ${name}
#   This syntax is less common but preferred. It is slightly more explicity,
#   aligns with the syntax required for arrays, and allows you to use the
#   variable with other text immediately following it.
echo "filename = ${filename}.gz"


## Inspecting variables ########################################################
################################################################################

# You can use `declare -p <variable>` to find any variables type (string, array,
# etc.) and value. This is useful for debugging.
declare -A some_map=([key1]="value1" [key2]="value2")
declare -p some_map

some_array=("Item 1" "Item 2" "Item 3")
declare -p some_array

some_string="Hello world"
declare -p some_string

some_int=1
declare -p some_int

# Note that the string and integer variables have the same declare output. This
# is because bash doesn't have a conventional number type. It uses strings for
# everything, and its built-in math functions simply happen to work if a string
# happens to contain only integers. You *can* use floating point numbers in
# bash scripts, but you need to use a secondary tool like `bc`. For more
# information, see examples/data-types.sh.


## Variable Names ##############################################################
################################################################################

# Variable names can contain letters, numbers, and underscores. They cannot
# start with a number.

# The following are all valid variable names:
valid_name="Alice"
valid_name2="Bob"
_valid_name_3="Charlie"
VALID_NAME="Dave"

# See examples/data-types.sh for more information on the different data types
# available to bash scripts.
