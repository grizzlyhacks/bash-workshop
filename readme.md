# Bash Workshop

## Installation

Before getting started, you'll want to make sure you have the latest version of
Bash installed.

### Windows

If you're on Windows, you'll need to install either Git Bash or WSL. If you
intend to do more than the basics, it's recommended to install WSL. Git Bash
comes with a complete Bash shell, but it's missing much of what you'd expect
from a typical unix + bash environment. WSL is a full Linux environment, and
will allow you to install any Linux package you might want to use in your bash
scripts.

- [Git Bash](https://git-scm.com/downloads)
- [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)

### Mac

MacOS comes with a fairly outdated version of Bash (3.2.57, released in 2007).
If you're on a Mac, you'll want to install a newer version of Bash. The most
common way to do this is to install Homebrew, and then install Bash using
Homebrew.

Homebrew is a package manager, much like `apt` on Ubuntu or the App Store on
your phone. It allows you to install and update software from the command line.
Since MacOS comes with many command line programs that are either outdated or
not compatible with some Linux bash scripts, Homebrew has the added benefit of
allowing you to install newer versions of these programs -- not just bash.

- [Homebrew](https://brew.sh/)
- [Installation Guide](https://www.shell-tips.com/mac/upgrade-bash/#upgrade-bash-on-mac-with-homebrew)

### Linux

If you're on Linux, you almost certainly already have a recent version of Bash
installed. But if you want to make sure, you can run one of the following:

#### Ubuntu / Debian

```bash
sudo apt update
sudo apt install bash
```

#### Fedora / CentOS

```bash
sudo yum update
sudo yum install bash
```

## Using the run script

This repository comes with a `run.sh` script that will print out the contents of
a file, running each code block inline. This is useful for running the examples
in this repository. To use it, simply run:

```bash
$ ./run.sh <filename>
```

Example:
```bash
$ ./run.sh examples/foo.sh
examples/foo.sh
#!/bin/bash
#
# This is a demo

> let a=1 b=2 c="a + b"
> echo "a = ${a}
a = 1

> echo "b = ${b}"
b = 2

> echo "c = ${c}"
c = 3
```

## About Bash

Bash is a command line shell. It's a program that runs in your terminal and
allows you to run commands. There are actually very few commands that are built
into Bash. Most of the commands you run are actually separate programs on your
computer. For example, `grep` is a commonly used program that searches for
patterns in files, but it's not part of Bash; it's a program (typically located
at `/bin/grep`) that Bash will run when you type `grep`.

You can see a list of the built-in features of Bash by running:

```bash
man builtins
```

## Environment variables

Bash has a number of environment variables that you can use to customize your
shell. You can view all of your environment variables by running `env`:

```bash
$ env
TERM_PROGRAM=Apple_Terminal
SHELL=/bin/bash
TERM=xterm-256color
...
```

You can also view the value of a single variable by using `echo`:

```bash
$ echo $TERM
xterm-256color
```

### PATH

The `PATH` variable is a list of directories that Bash will search when you run
a command. For example, if you run `ls`, Bash will search each directory in
`PATH` for a program called `ls`. If it finds one, it will run that program.

The default value of `PATH` is typically
`/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin`. So if you run `ls`, Bash will
search for `/usr/local/bin/ls`, then `/usr/bin/ls`, then `/bin/ls`, and so on.
Once it hits a match, it will run that program.

You can add more directories to your `PATH` by adding them to the end of the
variable in one of your startup scripts (see below).

`~/.bash_profile`
```bash
export PATH=$PATH:/usr/local/go/bin
```

### PS1

The `PS1` variable is used to customize your prompt. The default value is
`\h:\W \u\$ `, which will display your hostname, current working directory, and
username. You can customize this to display whatever you want. For example, if
you want to display the current time, you can use `\t`:

`~/.bash_profile`
```bash
export PS1="\t \u\$ "
```

## Startup script

When you open a new terminal, Bash will run a few startup scripts:
- `/etc/profile`
- `~/.bash_profile`
- `~/.bash_login`
- `~/.profile`
- `~/.bashrc`

The first one is run for all users, and the rest are run for the current user.
You can use these scripts to set up your environment, such as adding directories
to your `PATH` variable (see below), setting up your prompt, and generally
customizing your shell.

Bash doesn't always run *all* of these scripts. It depends on how you open your
shell. For example, if you open a new terminal window in MacOS, Bash will run
`/etc/profile`, `~/.bash_profile`, and `~/.bashrc`. But if you open a new
terminal tab, it will only run `~/.bashrc`. A common pattern to ensure that
everything is run is to add the following to your `~/.bash_profile`:

`~/.bash_profile`
```bash
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
```

This ensures that whenever `~/.bash_profile` is loaded, it will also load the
contents of `~/.bashrc`.
