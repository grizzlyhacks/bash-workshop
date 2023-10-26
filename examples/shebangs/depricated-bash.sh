#!/bin/bash
#
# ^ This shebang is deprecated.
##
# While #!/bin/bash is the most common shebang to see for bash scripts, it is
# not necessarily the best practice. Some systems might install bash in a
# different location.
#
# As an example, MacOS comes with an outdated version of bash, and it is very
# common practice to update it with Homebrew. The updated bash executable is
# located at /usr/local/bin/bash. If you were to use #!/bin/bash, your script
# would use the default, outdated version of bash. If you were to use
# #!/usr/local/bin/bash, your script would fail on other systems that do not
# have bash installed in that location. The best practice is to use
# "#!/usr/bin/env bash" which will use the bash executable in the current
# environment.

echo "hello world"
