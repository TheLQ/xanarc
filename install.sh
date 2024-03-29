#!/bin/bash
# install links
set -euo pipefail
IFS=$'\n\t'

[ "$PWD" != "$HOME/xanarc" ] && (
	echo "not in right directory"
	exit 1
)
[ "$0" != "./install.sh" ] && {
	echo "must call in correct directory, currently $0"
}
rc_home="$HOME/xanarc"

replace() {
	[ "$1" == "" ] || [ "$2" == "" ] && (
		echo "replace <rcfile> <targetfile>"
		exit 1
	)
	file_rc="$rc_home/$1"
	file_home="$HOME/$2"

	do_overwrite="no"

	echo "+ Link $1 to $2"

	if [ -h "$file_home" ] && [ "$( readlink "$file_home" )" == "$file_rc" ]; then
		echo "bashrc link already set"
	elif [ -f "$file_home" ]; then
		echo "backing up existing config"
		mv "$file_home" "$file_home.orig"
		do_overwrite="yes"
	fi
	if [ "$do_overwrite" == "yes" ] || [ ! -f "$file_home" ]; then
		echo "creating link"
		ln -s "$file_rc" "$file_home"
	fi
}

replace "bashrc.sh" ".bashrc"
replace "gitconfig" ".gitconfig"

echo "done"
