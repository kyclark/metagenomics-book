#!/bin/bash

DIR="fasta"
WGET="wget -nc -P $DIR"

if [[ ! -d "$DIR" ]]; then
    mkdir -p "$DIR"
fi

BASE='http://downloads.yeastgenome.org/sequence/S288C_reference/chromosomes/fasta'
for i in $(seq 1 16); do
    URL=$(printf '%s/chr%02d.fsa' "$BASE" "$i")
    $WGET "$URL"
done

$WGET "$BASE/chrmt.fsa"

echo "Done."
