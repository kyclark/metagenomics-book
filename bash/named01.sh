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

if [[ $# -eq 0 ]]; then
  USAGE 1
fi

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

if [[ ${#GREETING} -lt 1 ]]; then
  USAGE 1
fi

echo "$GREETING, $NAME"
