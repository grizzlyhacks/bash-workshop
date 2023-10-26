#!/usr/bin/env bash
#
# This script demonstrates bash pipes.

## Pipes #######################################################################
################################################################################

# Pipes in bash are used to connect the output of one command to the input of
# another command. They are represented by the | character.

# For example, the following command will print the contents of the current
# directory and then pipe that output to the `wc` command which will count the
# number of lines, words, and characters in the output.

# View the filetypes of everything in the current directory
ls

# Pipe the output of `ls` to `wc`
ls | wc

# Uppercase the output of `ls`
ls | tr '[a-z]' '[A-Z]'


## Piping output to a loop #####################################################
################################################################################

# You can pipe the output of a command to a loop to iterate over each line of
# output. This is useful if you want to perform an action on each line of
# output.

ls | while read filename; do
    echo "filename = ${filename}"
done


## Piping to/from any code block ###############################################
################################################################################

# In fact, you can pipe to or from any code block. This is useful if you want to
# perform multiple actions on the output of a command or loop.

# Print the contents of the current directory
ls | while read filename; do
    # Print the filename
    echo "filename = ${filename}"
done

# Print the contents of the current directory and capitalize everything
ls | while read filename; do
    # Print the filename
    echo "filename = ${filename}"
done | tr '[a-z]' '[A-Z]'

name="Alice"
if [[ "${name}" == "Alice" ]]; then
    echo "Her name is Alice."
fi | tr '.' '!' # Replace the '.' with a '!'
