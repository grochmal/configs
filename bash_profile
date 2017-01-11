#!/bin/sh
#
# ~/.bash_profile
#
# There is a test for non-interactive shell at the beginning of .bashrc so it
# should be fine to load every time.  Since .bashrc can contain bash specific
# things load it from .bash_profile and take the .profile environment
# definitions from inside .bashrc, which runs as a POSIX shell anyway.

test -r "$HOME/.bashrc"  && source "$HOME/.bashrc"

