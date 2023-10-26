#!/usr/bin/env bash
#
# This script demonstrates bash arrays.

## Creating arrays #############################################################
################################################################################

# Arrays are a collection of strings. They are declared in one of three ways:
#  - Declare an empty array
declare -a arr1
declare -p arr1 # prints the type and value of a variable

#  - Declare an array with values
arr2=("Alice" "Bob" "Charlie")
declare -p arr2

#  - Assign values to an array
arr3[0]="Alice"
arr3[1]="Bob"
arr3[2]="Charlie"
declare -p arr3


## Accessing array elements ####################################################
################################################################################

# You can access individual elements of an array by their index:
echo "arr2[0] = ${arr2[0]}"
echo "arr2[1] = ${arr2[1]}"
echo "arr2[2] = ${arr2[2]}"

# You can also access all elements of an array by using the @ or * special
# variables:
arr4=("hello world" "lots   of   spaces")
echo "arr4 contains: ${arr4[@]}"
echo "arr4 contains: ${arr4[*]}"


# - @ expands to each element as a separate item. This is the most common way to
#     iterate over an array and allows you to 1) pass the array as a list of
#     arguments to a command, and 2) iterate over the array with a for loop.
for item in "${arr4[@]}"; do
  echo "item = ${item}"
done

printf "  - %s\n" "${arr4[@]}"

# - * expands the entire array as a single string, with each element separated
#     by a space. This is useful for printing the entire array as a single
#     string, but not much else.
for item in "${arr4[*]}"; do
  echo "item = ${item}"
done

printf "  - %s\n" "${arr4[*]}"
