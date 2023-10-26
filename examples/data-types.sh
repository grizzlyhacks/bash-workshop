#!/usr/bin/env bash
#
# This script demonstrates the various data types available to bash scripts.

echo "# Bash Data Types #"

echo "- Strings"
echo "- Numbers"
echo "- Arrays"
echo "- Associative Arrays"
echo "- Booleans (kind of)"

echo
echo "## Strings ##"

# Bash supports 3 different syntaxes for strings:
#  - 'Single quoted strings'
#    These will not expand variables or escape characters -- they are literal
echo 'This is a single quoted string. It will print a literal $USER and \n.'
#  - "Double quoted strings"
#    These will expand variables but not escape characters
echo "This is a double quoted string. It will expand variables like $USER but not special characters like \n."
#  - $'ANSI-C quoted strings'
#    These will not expand variables but will expand escape characters
echo $'This line will print the newline \n character but not the $USER variable.'


echo
echo "## Numbers ##"

# Bash doesn't have a conventional number type. Its built-in math functions
# only handle integers, and ultimately all numbers are stored as strings. The
# math operations simply work if those strings happen to be numbers. Decimals
# are right out without using a secondary tool like `bc`.
num=1
echo "num = ${num}"
# As far as math operations, there are a few different syntaxes:
#  - $((math expression))
#    This is the most common syntax and allows you to use variables and most
#    basic math operators: +, -, *, /, %, **, ++, --
num=$((num + 10)) # 11
echo "num + 10 = ${num}"
num=$((num / 2)) # 5, note that it not only rounds (integers), but it always rounds down
echo "num / 2 = ${num}"
#  - let <var>=<math expression>
#    This is a bit more verbose but allows you to use more advanced math
#    operators like *=, /=, %=, +=, -=, <<=, >>=, &=, ^=, |=
let num+=10 # 14
echo "num += 10 = ${num}"
let num/=2 # 7
echo "num /= 2 = ${num}"
let num-- # 6
echo "num-- = ${num}"

echo
echo "## Arrays ##"

# An array is a collection of values. You can create a new array in one of
# three ways:
#  - Declare an empty array
declare -a empty_array
#  - Declare an array with no values
new_array=()
#  - Declare an array with values
fruits=("apple" "banana" "cherry" "date" "elderberry")

# You can access individual elements of an array by index
echo "fruits[0] = ${fruits[0]}"
echo "fruits[1] = ${fruits[1]}"

# You can also 