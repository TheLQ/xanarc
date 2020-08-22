#!/bin/sh

# See /usr/share/doc/bash-doc/examples in the bash-doc package.

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias journal24h='journalctl --since="24 hours ago"'

relink() {
	if [ ! -n "$1" ] || [ ! -h "$1" ] || [ ! -n "$2" ]; then
		echo "relink <softLinkfile> <target>"
		return 1
	fi
	set -x
	unlink "$1"
	ln -s "$2" "$1"
	set +x
}

cdtmp() {
	if [ -e "$1" ]; then
		echo "cdtmp <tmp that does not exist>"
		return 1
	fi
	set -x
	mkdir "/tmp/$1"
	cd "/tmp/$1" || return
	set +x
}

reloadbashrc() {
    source "$HOME"/.bashrc
}

##

alias dc='docker-compose'
alias dcup='docker-compose up -d'
alias dcstop='docker-compose stop'
alias dclogs='docker-compose logs -f'
alias dcbuild='docker-compose build'
alias dcbuildpull='docker-compose build --pull'
alias dps='docker ps | less -S'

dcstopup() {
	set -x;
	docker-compose stop "$1"
	docker-compose up -d "$1"
	set +x;
}
dcattach() {
	set -x;
	docker-compose exec "$1" /bin/bash;
	set +x;
}
dcrm() {
	set -x;
	docker-compose stop "$1";
	docker-compose rm "$1";
	set +x
}

##

alias lxcls="lxc-ls --fancy"
alias lxcstart="lxc-start -n"
alias lxcstop="lxc-stop -n"
alias lxcls="lxc-ls -f"

lxcstopup() {
	if [ -z "$1" ]
	then
		echo "lxcstopup <container>"
		return 1
	fi
	set -x;
	lxc-stop -n "$1"
	lxc-start -n "$1"
	set +x
}

lxcrestartattach() {
    if [ -z "$1" ]
	then
		echo "lxcrestartattach <container>"
		return 1
	fi
    set -x
    lxc-stop -n "$1"
    lxc-start -n "$1"
    lxc-attach -n "$1"
    set +x
}

lxcedit() {
    if [ -z "$1" ]
	then
		echo "lxcedit <container>"
		return 1
	fi
    set -x
    nano "/var/lib/lxc/$1/config"
    set +x
}

lxcattach() {
	if [ "$1" == "" ]; then
		echo "lxcattach <container>"
		return 1
	fi
	set -x
	lxc-attach -n "$1"
	set +x
}

lxcsh() {
	if [ "$1" == "" ]; then
                echo "$0 <container>"
                return 1
        fi
	set -x
	lxc-attach --clear-env -n "$1" /bin/bash
	set +x
}
lxcshleon() {
	if [ "$1" == "" ]; then
                echo "$0 <container>"
                return 1
        fi
	set -x
	lxc-attach --clear-env -n "$1" --u 1000 --g 1000 /bin/bash
	set +x
}

##

alias gc='git commit'

gac() {
	if [ -e "$1" ]; then
		echo "gitaddcommit <file>"
		return 1
	fi
	set -x
	git add "$1"
	git commit
	set +x
}

##

alias iftop50='iftop -m 50m'
alias iftop100='iftop -m 100m'
alias iftop200='iftop -m 200m'

alias iotop='iotop -o'
