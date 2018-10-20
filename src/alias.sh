#!/bin/sh

# See /usr/share/doc/bash-doc/examples in the bash-doc package.

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias journal24h='journalctl --since="24 hours ago"'

relink() {
	[ -n "$1" -a -h "$1" -a -n "$2" ] || { echo "relink <softLinkfile> <target>" && exit 1; }
	set -x
	unlink "$1"
	ln -s "$2" "$1"
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
    [ "$1" == "" ] && echo "lxcRestartAttach <container>" && return 1
    set -x
    lxc-stop -n "$1"
    lxc-start -n "$1"
    lxc-attach -n "$1"
    set +x
}

lxcedit() {
    [ "$1" == "" ] && echo "lxcEdit <container>" && return 1
    set -x
    nano "/var/lib/lxc/$1/config"
    set +x
}

lxcattach() {
	[ "$1" == "" ] && echo "lxcAttach <container>" && return 1
	set -x
	lxc-attach -n "$1"
	set +x
}
lxcls() {
	set -x
	lxc-ls -f
	set +x
}

