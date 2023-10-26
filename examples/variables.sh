#!/usr/bin/env bash
#
# This script demonstrates the various data types available to bash scripts.

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
