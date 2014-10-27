# .profile
# Invoked on login shells, it will not be run by bash if there is no
# .bash_profile and there is not .bash_login in the home directory.
# Example of login shells are:
# $ su -
# bash --login
# ssh me@host

# Get the aliases and functions
if [ -f $HOME/.bashrc ]; then
  . $HOME/.bashrc
fi

