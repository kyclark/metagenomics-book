#!/bin/bash

set -u

YEARS="years"

cut -f 2 ./*.cc.txt | sort | uniq > "$YEARS"
NUM=$(wc -l $YEARS | awk '{print $1}')

if [[ "$NUM" -lt 1 ]]; then
  echo "No years ($NUM)!"
  exit 1
fi

while read -r YEAR; do 
    echo -n "$YEAR: " 
    awk -F"\t" "\$2 == $YEAR { printf \"%d\\n\", \$3 }" ./*.cc.txt | grep -v "[a-z]" | paste -sd+ - | bc
done < "$YEARS"
