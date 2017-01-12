#!/bin/sh
#
# ~/.profile
#
# Remember that .profile is a POSIX bourne shell file.  No bash or zsh
# extensions shall ever make its way in here.

# be non-permissive by default
umask 022

# our own scripts, and scripts used by scripting languages
export PATH="$HOME/.bin:$HOME/.local/bin:$PATH"

# termcap and manpath should not be used, terminfo and mandb are better
unset TERMCAP
unset MANPATH

# we may have some sensitive environment to set
if test -r "$HOME/rc/rc/profile_personal.sh"
then
    source "$HOME/rc/rc/profile_personal.sh"
fi

# some ncurses programs have problems with this (e.g. mutt)
if test 'rxvt-unicode-256color' = "$TERM"
then
    export TERM=rxvt-unicode
fi

# typical program config
export EDITOR=vim
export LESS='-iMSx4 -FXR'

# useful things
alias 'ls=ls --color=auto'

# metasploit (favourite place for the db config)
export MSF_DATABASE_CONFIG=/opt/metasploit/config/database.yml

