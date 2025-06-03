#!/bin/bash

# # set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi

# # set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
#     xterm-color|*-256color) color_prompt=yes;;
# esac

# if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
# 	# We have color support; assume it's compliant with Ecma-48
# 	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
# 	# a case would tend to support setf rather than setaf.)
# 	color_prompt=yes
# else
# 	color_prompt=
# fi

function __prompt_title() {
    # Set terminal title
    echo -en "\e]0;$USER@$HOSTNAME"
}

PROMPT_COMMAND=__prompt_command
__prompt_command() {
    local curr_exit="$?"

    # next time: Wrap all of these in \[ ... \]
    local red='\e[31m'
    local green='\e[32m'
    local blue='\e[96m'

    local clear='\e[0m'

    # \[
    #     begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
    # \]
    #     end a sequence of non-printing characters
    local start='\['
    local end='\]'

    case $USER in
      root)
         __prompt_user_color='\e[48;5;13m'
         ;;
      *)
         __prompt_user_color='\e[38;5;10m'
         ;;
    esac
    local __prompt_user="${start}${__prompt_user_color}${end}\u${start}${clear}${end}"

    case $HOSTNAME in
        lyoko)
          __prompt_host_color='\e[31m'
          __prompt_host_text='╡█\h█╞'
          ;;
        *)
          __prompt_host_color='\e[32m'
          __prompt_host_text='\h'
          ;;
    esac
    local __prompt_host="${start}${__prompt_host_color}${end}${__prompt_host_text}${start}${clear}${end}"

    local __prompt_dir="${start}${blue}${end}\w${start}${clear}${end}"
    

    # ${debian_chroot:+($debian_chroot)}
#   if [ "$color_prompt" = yes ]; then
       PS1="${__prompt_user}@${__prompt_host}:${__prompt_dir}\$ "
#   else
#       PS1='\u@\h:\w\$ '
#   fi

   if [ "$curr_exit" != 0 ]; then
       PS1="${start}${red}${end}$curr_exit${start}${clear}${end} $PS1"
   fi

    # append missing current session history into .bash_history
    history -a
    # append missing .bash_history entries into current session
    history -n

    # if a child chroot/lxc exits, reset the terminal title
   __prompt_title
}
