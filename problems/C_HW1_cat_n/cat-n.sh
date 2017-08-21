#!/bin/bash

if [[ $# -ne 1 ]]; then
    printf "Usage: %s FILE\n" "$(basename "$0")"
    exit 1
fi

FILE=$1
i=0
while read -r LINE; do
    let i++
    echo "$i $LINE"
done < "$FILE"
