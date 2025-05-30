#!/bin/bash

__export_path() {
  if [ -z "$1" ]; then 
    echo "no path";
    return;
  fi

  case ":${PATH}:" in
    *:"$1":*)
        echo "already supports $1"
        ;;
    *)
        echo "supports $1"
        export PATH="$PATH:$1"
        ;;
  esac
}

# tmsu?
# export PATH="$PATH:/mnt/bin/linux/bin"

__export_path "/opt/AMDuProf_5.0-1479/bin/"

if [ -f "$HOME/.cargo/env" ]; then
  echo "adding cargo"
  . "$HOME/.cargo/env"
fi

# contains non-trivial, complex functions

# utils:
# namei

linklevels() {
    file="$1"
    if [ ! -h "$file" ]; then
		echo "linklevels <symlinkFile>"
		return 1
	fi

    while [ -h "$file" ]; do
        echo "$file"
        file=$(readlink -f "$file")
        echo "new $file"
    done
}

zfstogglero() {
  volume="$1"
  if [ -z "$volume" ]; then
    echo "need volume"
    return 1
  fi

  if [ "$(zfs get readonly -Ho value $volume)" = "on" ]; then
    set -x
    zfs set readonly=off $volume
    set +x
  else
    set -x
    zfs inherit readonly $volume
    set +x

    if [ "$(zfs get readonly -Ho value $volume)" != "on" ]; then
      echo "readonly still off from parent!"
      return 5
    fi

  fi
}
