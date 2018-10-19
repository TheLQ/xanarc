#!/bin/sh

# See /usr/share/doc/bash-doc/examples in the bash-doc package.

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"