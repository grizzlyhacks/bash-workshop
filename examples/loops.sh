#!/usr/bin/env bash
#
# This script demonstrates bash loops

## For Loops ###################################################################
################################################################################

# For loops are the most common type of loop in bash. They are used to iterate
# over a list of items. There are two syntaxes for for loops:

# 1. for <item> in <list>; do <commands>; done
#   This syntax is the most common and is used to iterate over a list of items.
#   The list can be a literal list of items, a variable with spaces separating
#   items, a command substitution that returns a list of items, a file glob, or
#   an array.

## Literal list
for i in 1 2 3 4 5; do
  echo "i = ${i}"
done

## Variable with spaces
students="Alice Bob Charlie"
for student in ${students}; do
  echo "student = ${student}"
done

## Command substitution
for file in $(ls); do
  echo "file = ${file}"
done

## File glob
for file in *; do
  echo "file = ${file}"
done

## Array
students=("Alice" "Bob" "Charlie")
for student in ${students[@]}; do
  echo "student = ${student}"
done

# 2. for ((<start>; <end>; <step>)); do <commands>; done
#   This syntax is used to iterate over a range of numbers. The start, end, and
#   step values can be any math expression. The step value is optional and
#   defaults to 1. The end value is also optional and defaults to infinity.

## Standard usage
for ((i=0; i<10; i++)); do
  echo "i = ${i}"
done

## Skip every other number
for ((i=0; i<10; i+=2)); do
  echo "i = ${i}"
done

## Count backwards
for ((i=10; i>0; i--)); do
  echo "i = ${i}"
done


## While Loops #################################################################
################################################################################

# While loops are used to run a block of code until an expression returns a
# false status code. This expression can be a condition or command.

## Condition -- standard usage
i=0
while [[ ${i} -lt 10 ]]; do
  echo "i = ${i}"
  let i++
done

## Command
cur_minute=$(date +"%H:%M")
# Loop until it is no longer the same minute
while date +"%H:%M" | grep -qF "${cur_minute}"; do
  echo "Waiting until it is no longer ${cur_minute}..."
  sleep 1
done
