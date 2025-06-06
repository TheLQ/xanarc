#!/bin/bash

# The dark arts of terminal escape sequences
#
# Simple: https://ghostty.org/docs/vt/concepts/sequences
# Reference: https://invisible-island.net/xterm/ctlseqs/ctlseqs.html
# \e[ - ANSI Escape Sequences
# \e] - OSC Escape Sequences

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

    # https://tldp.org/HOWTO/Bash-Prompt-HOWTO/xterm-title-bar-manipulations.html
    # http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#toc4
    # https://chromium.googlesource.com/apps/libapps/+/a5fb83c190aa9d74f4a9bca233dac6be2664e9e9/hterm/doc/ControlSequences.md#OSC
    # local __title_bar="${start}\e]2;X\u@\h\007${end}"

    # Set tmux-specific title
    # https://manpages.debian.org/bookworm/tmux/tmux.1.en.html#NAMES_AND_TITLES
    # local __title_bar="\ek$USER@$HOSTNAME\e\\"

    # final config
    PS1="${__title_bar}${__prompt_user}@${__prompt_host}:${__prompt_dir}\$ "
    if [ "$curr_exit" != 0 ]; then
        PS1="${start}${red}${end}$curr_exit${start}${clear}${end} $PS1"
    fi

    # append missing current session history into .bash_history
    history -a
    # append missing .bash_history entries into current session
    history -n
}
