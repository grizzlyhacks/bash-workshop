#!/usr/bin/env bash
#
# This script demonstrates how to declare variables in bash.

echo "# Variables #"

echo
echo "## Variable Declaration ##"

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

# See examples/data-types.sh for more information on the different data types
# available to bash scripts.
