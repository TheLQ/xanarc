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
    source $HOME/.bashrc
}

##

alias dc='docker-compose'
alias dcup='docker-compose up -d'
alias dcstop='docker-compose stop'
alias dclogs='docker-compose logs'
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

lxcstopup() {
	set -x;
	lxc-stop -n "$1"
	lxc-start -n "$1"
	set +x
}

lxcrestartattach() {
    if [ ! -n "$1" == "" ]; then
		echo "lxcRestartAttach <container>"
		return 1
	fi
    set -x
    lxc-stop -n "$1"
    lxc-start -n "$1"
    lxc-attach -n "$1"
    set +x
}

lxcedit() {
    if [ ! -n "$1" ]; then
		echo "lxcEdit <container>"
		return 1
	fi
    set -x
    nano "/var/lib/lxc/$1/config"
    set +x
}

lxcattach() {
	if [ "$1" == "" ]; then
		echo "lxcAttach <container>"
		return 1
	fi
	set -x
	lxc-attach -n "$1"
	set +x
}
lxcls() {
	set -x
	lxc-ls -f
	set +x
}

##

alias gc='git commit'
gitaddcommit() {
	if [ -e "$1" ]; then
		echo "gitaddcommit <file>"
		return 1
	fi
	set -x
	git add "$1"
	git commit
	set +x
}