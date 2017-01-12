#!/bin/sh
#
# ~/.xsession - must be executable (permissions)
#
# Executed by a display manager to generate a session,
# just use .xinitrc for that.

if test -r "$HOME/.xinitrc"
then
    source "$HOME/.xinitrc"
fi

