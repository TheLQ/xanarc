#!/bin/sh

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
