#!/bin.sh
#
# ~/.bashrc
#
# This file is bash specific, changes to the environment and non-shell specific
# aliases should go inside .profile instead.

# To speed things up we can check if we are under a non-interactive shell and
# return straight away.  This only makes sense for POSIX compatible shells, in
# this case bash and zsh.  For dash, we don't bother since (1) it is quite hard
# to check whether we are running inside a dash session and (2) dash should be
# quick enough to process the initialisation anyway.
#
# We use a bash and zsh built-in to perform the glob check.  Since we don't
# bother with other shells that should work on these two shells and be ignored
# by any other shell (including dash or fish).
if test "$BASH_VERSION" -o "$ZSH_VERSION"
then
    [[ $- != *i* ]] && return
fi

# Next load the environment from .profile, this should have been done already
# in most cases but do it again for the cases in which it has not been done.
test -r "$HOME/.profile" && source "$HOME/.profile"

PS1='[\u@\h \W]\$ '

