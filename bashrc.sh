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

echo $PWD
for i in ./xanarc/src/*.sh; do
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
[ -r /root/.byobu/prompt ] && . /root/.byobu/prompt   #byobu-prompt#

set +euo pipefail
IFS="$old_ifs"