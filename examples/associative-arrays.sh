#!/usr/bin/env bash
#
# This script demonstrates associative arrays.

## Creating associative arrays #################################################
################################################################################

# Associative arrays are a collection of key-value pairs, like Java HashMaps or
# Python dictionaries. They are declared in one of three ways:
#  - Declare an empty associative array
declare -A arr1
declare -p arr1 # prints the type and value of a variable

#  - Declare an associative array with values
arr2=([name]="Alice" [age]=20)
declare -p arr2

#  - Assign values to an associative array
arr3[name]="Alice"
arr3[age]=20
declare -p arr3


## Accessing associative array elements ########################################
################################################################################

arr4=([name]="Alice" [age]=20)

# You can access individual elements of an associative array by their key:
echo "arr4[name] = ${arr4[name]}"
echo "arr4[age] = ${arr4[age]}"

# You can also access all elements of an associative array by using the @ or *
# special variables:
echo "arr2 contains: ${arr2[@]}"


## Looping over elements #######################################################
################################################################################

# Looping over the elements of an associative array is a bit different than in
# in other languages or looping over bash arrays. You need to use ${!arr[@]} to
# first get the list of keys, then use those keys to get the values.

# This will print the keys of the array:
echo "arr4 keys: ${!arr4[@]}"

# Then we can use those keys in a for loop to get the values:
for key in "${!arr4[@]}"; do
    key_value="${arr4[${key}]}"
    echo "${key} = ${key_value}"
done
