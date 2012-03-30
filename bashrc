# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# I need to be invoked manually by login shells

### TOP LEVEL PARAMETERS
### change me for quick re-config

# PATH
# default path
# begin with a path derived from getconf, if available.
#if [ -x /usr/bin/getconf ]; then
#	PATH=$(/usr/bin/getconf PATH)
#fi

# PREFIX
# base directory for unix-like operations.
# bin, etc, lib, share & the like live here.
# software builds should be able to set --prefix=$PREFIX
export PREFIX=$HOME/.local

# RC
# a directory (probably .bash.d) that holds additional configuration
# information for bash. There are a few different elements here:
# 	$RC/bash_*				various bash support files (functions, aliases, etc)
# 	$RC/bashrc-host.$name	host-specific bashrc extensions
# 	$RC/bashrc.$name		subsystem-specific bashrc extensions
#	$RC/bashrc_n_##*		non-interactive extensions, run for all bash's
# 	$RC/bashrc_i_##*		interactive only extensions, run for interactives only.
export RC=$HOME/.bash.d

#### END PARAMETERS
### non-interactive section. Invoked always

# the default umask is set in /etc/profile
umask 022

# include .bash_functions (helper functions) if it exists
if [ -f $RC/bash_functions ]; then
    . $RC/bash_functions
fi


# global paths

# common paths
path_prepend /opt/local/sbin
path_prepend /opt/local/bin
path_prepend /usr/local/sbin
path_prepend /usr/local/bin

# host-specific setup base on uname -n
[ -f $RC/bashrc-host.$HOSTNAME ] && . $RC/bashrc-host.$HOSTNAME

# load subsystems
shopt -s nullglob
for i in $RC/bashrc.*; do
	. $i
done
shopt -u nullglob

# source init-style non-interactive extensions
shopt -s nullglob
for i in $RC/bashrc_n_*; do
	. $i
done
shopt -u nullglob

# my bin dir trumps everything
path_prepend $PREFIX/bin

### interactive-only section.
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions (if any)
[ -f /etc/bashrc ] && . /etc/bashrc

# configure common working paths
export CDPATH=.:~:~/bin:~/cavern_logs:/export/logs

# ignore common commands
export HISTIGNORE='&:ls:[bf]g:exit'
# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# Various settings
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkhash
shopt -s extglob
shopt -s checkwinsize
shopt -s cmdhist
shopt -s no_empty_cmd_completion
shopt -s histappend histreedit
shopt -s extglob

# Uncomment this below for a color prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
if [ -f $RC/bash_aliases ]; then
    . $RC/bash_aliases
fi

# source init-style interactive extensions
shopt -s nullglob
for i in $RC/bashrc_i_*; do
	. $i
done
shopt -u nullglob

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

