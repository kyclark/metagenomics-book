#!/bin/bash

set -u

GREETING=""
NAME="Stranger"

function USAGE() {
    printf "Usage:\n  %s -g GREETING [-n NAME]\n\n" $(basename $0)
    echo "Required arguments:"
    echo " -g GREETING"
    echo
    echo "Options:"
    echo " -n NAME ($NAME)"
    echo 
    exit ${1:-0}
}

[[ $# -eq 0 ]] && USAGE 1

while getopts :g:n:h OPT; do
  case $OPT in
    h)
      USAGE
      ;;
    g)
      GREETING="$OPTARG"
      ;;
    n)
      NAME="$OPTARG"
      ;;
    :)
      echo "Error: Option -$OPTARG requires an argument."
      exit 1
      ;;
    \?)
      echo "Error: Invalid option: -${OPTARG:-""}"
      exit 1
  esac
done

[[ -z "$GREETING" ]] && USAGE 1

echo "$GREETING, $NAME!"
