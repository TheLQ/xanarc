#!/bin/sh

lastmodifiedrecursive() {
    find . -type f -printf '%T@ %c %p\n' | sort -n | cut -f2- -d' '
}
