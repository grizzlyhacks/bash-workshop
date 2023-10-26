#!/bin/bash -x

# The first line of this script is a "shebang". It tells the shell what
# program to use when running this as a script. When you run a script directly,
# i.e. via `./script.sh`, the shell will essentially run:
#   {shebang} {script} {arguments}

# For example, if you run this script like this:
#   ./examples/shebangs/bash.sh
# The shell will run:
#   /bin/bash -x ./examples/shebangs/bash.sh
#
# If you run this script like this:
#   ./examples/shebangs/bash.sh foo bar
# The shell will run:
#   /bin/bash -x ./examples/shebangs/bash.sh foo bar
# And pass the arguments "foo" and "bar" to the script.
#
# Lastly, if you run this script like this:
#   bash ./examples/shebangs/bash.sh foo bar
# The shell will run:
#   bash ./examples/shebangs/bash.sh foo bar
# Note that the `-x` option is missing. This is because the shebang is not
# used when running a script with `bash`. The shebang is only used when you run
# a script directly without specifying the interpreter on the command line.

echo "You passed ${#} arguments to this script:"
for ((i=0; i<${#}; i++)); do
  echo "  ${i}: ${@}"
done
