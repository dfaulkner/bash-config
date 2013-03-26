# ~/.bash_profile: executed by the command interpreter for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile
# umask of 002 makes files group-writable by default.
# supports "user private group" model.
umask 002




# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi


