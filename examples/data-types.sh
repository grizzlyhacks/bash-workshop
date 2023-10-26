#!/usr/bin/env bash
#
# This script demonstrates the various data types available to bash scripts.

## Data Types ##################################################################
################################################################################

# Bash has 3 data types:
#  - Strings
#  - Arrays
#  - Associative Arrays
#
# You *can* use other data types like integers, floats, and booleans, but they
# aren't necessarily first-class citizens. More on that below.

## Strings #####################################################################
################################################################################

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


## Arrays ######################################################################
################################################################################

# An array is a collection of values. In bash, the values are always strings.
# You can create and use a new array like so:
arr=("apple" "banana" "cherry" "date" "elderberry")

# Print the contents of the array
echo "arr = ${arr[@]}"

# Print the size of the array
echo "arr size = ${#arr[@]}"

# Loop over the array
for item in "${arr[@]}"; do
    echo "item = ${item}"
done


## Associative Arrays ##########################################################
################################################################################

# An associative array is a collection of key-value pairs. In bash, the keys
# and values are always strings. You can create and use a new associative array
# like so:
declare -A arr2=([name]="Alice" [age]=20)

# Print the keys of the associative array
echo "arr2 = ${arr2[@]}"

# Print the size of the associative array
echo "arr2 size = ${#arr2[@]}"

# Loop over the associative array
for key in "${!arr2[@]}"; do
    key_value="${arr2[${key}]}"
    echo "${key} = ${key_value}"
done


## Numbers #####################################################################
################################################################################

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

## Floating point numbers

# While bash doesn't have a built-in floating point number type, you can use
# `bc` to do floating point math. `bc` is a command line calculator. It takes
# input from stdin and prints the result to stdout. You can use it like so:
a=1.5
b=2.5
echo "${a} + ${b}" | bc # 4.0


## Booleans ####################################################################
################################################################################

# Bash doesn't have a conventional boolean type. However, a common approach is
# to use the `true` and `false` commands
true
echo "exit status = ${?}"

false
echo "exit status = ${?}"

# If a command returns a 0 exit status, it is considered "truthy". Otherwise,
# it is considered "falsy". This allows you to use commands in if statements.

if true; then
    echo "true is truthy"
fi

if false; then
    echo "false is truthy"
else
    echo "false is falsy"
fi

# We can use this to create a boolean variable. Note that the variable is
# actually a string, but we can use it as a boolean.
is_true="true"
if ${is_true}; then
    echo "is_true is truthy"
fi

is_false="false"
if ${is_false}; then
    echo "is_false is truthy"
else
    echo "is_false is falsy"
fi
