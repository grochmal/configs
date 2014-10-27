# .bashrc
# invoked on non-login shells only, e.g.
# $ sudo su
# $ bash
# $ ssh me@host /path/to/command

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Sensitive definitions (e.g. email address)
if [ -f $HOME/rc/rc/bash_personal ]; then
  .  $HOME/rc/rc/bash_personal
fi

export EDITOR=vim
export PATH=$HOME/local/bin:$PATH
export MANPATH=$HOME/local/share/man:$HOME/local/man:$MANPATH

