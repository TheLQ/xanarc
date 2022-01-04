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

# Set terminal title
echo -en "\033]0;$USER@$HOSTNAME\a"

PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local curr_exit="$?"

    # next time: Wrap all of these in \[ ... \]
    local Clear='\e[0m'
    local Red='\e[31m'
    local Green='\e[32m'

    # ${debian_chroot:+($debian_chroot)}
   if [ "$color_prompt" = yes ]; then
       PS1="\[${Green}\]\u\[${Clear}\]@\[${__prompt_host_color}\]\h\[${Clear}\]:\[${Blue}\]\w\[${Clear}\]\$ "
   else
       PS1='\u@\h:\w\$ '
   fi

   if [ "$curr_exit" != 0 ]; then
       PS1="\[${Red}\]$curr_exit\[${Clear}\] $PS1"
   fi

    # append missing current session history into .bash_history
    history -a
    # append missing .bash_history entries into current session
    history -n
}
