#!/bin/sh

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
else
	color_prompt=
fi

PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local curr_exit="$?"

    # next time: Wrap all of these in \[ ... \]
    local Clear='\e[0m'
    local Red='\e[91m'
    local Magenta='\e[35m'
    local Green='\e[32m'
    local Blue='\e[34m'



    # ${debian_chroot:+($debian_chroot)}
#    if [ "$color_prompt" = yes ]; then
    PS1="\[${Green}\]\u\[${Clear}\]@\[${Magenta}\]\h\[${Clear}\]:\[${Blue}\]\w\[${Clear}\]\$ "
#    else
#        PS1='\u@\h:\w\$ '
#    fi

#    if [ "$curr_exit" != 0 ]; then
#        PS1="\[${Red}\]$curr_exit\[${Clear}]\]$PS1"
#    fi

    history -a
    history -n
}
