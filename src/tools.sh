#!/bin/bash

export PATH="$PATH:/mnt/bin/linux/bin"

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
