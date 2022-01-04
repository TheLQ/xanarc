#!/bin/bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# temporary debug
# set -euo pipefail
# old_ifs="$IFS"
# IFS=$'\n\t'

# export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

xanarc_root="$HOME/xanarc"
for i in "$HOME"/xanarc/src/*.sh; do
  echo "import $i"
  . "$i"
done

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# byobu-prompt - needed otherwise junk gets written to the first new shell
[ -r /root/.byobu/prompt ] && . /root/.byobu/prompt   #byobu-prompt#

# Set language for commands to UTF-8 instead of ASCII. Needed to render filenames with foreign characters
# For some reason we didn't need this before... update-locales, set default to none, etc didn't work
export LANG=en_US.UTF-8

# alert if we need to commit xanarc
if [ -f /usr/bin/git ]
then
	{
	git_cmd=( "git" "-C" "$xanarc_root" )
	[[ -z $( "${git_cmd[@]}" status -uno --porcelain) ]] || (
		lastFile=$( "${git_cmd[@]}" status --porcelain | grep -E "[A-Z ]{2}" | cut -c4- | xargs printf -- "$xanarc_root/%s\n" | xargs ls -t | tail -n1 )
		last_modified_sec=$(stat --format '%Y' "$lastFile")
		now_sec=$(date +%s)
		echo
		#echo "$last_modified_sec - $now_sec = " $(( now_sec - last_modified_sec ))
		total_hours=$(( ( now_sec - last_modified_sec ) / ( 60 * 60 ) ))
		total_days=$(( ( now_sec - last_modified_sec ) / ( 60 * 60 * 24 ) ))
		echo "need to commit xanarc changes, at least $total_hours hours or $total_days days old"
	)
}
fi
