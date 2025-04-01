#!/bin/bash
source "$( dirname "${BASH_SOURCE[0]}")"/bin/dir.sh
source "$ROOT_DIR/bin/utils/fzf.sh"

# @doc
#
# A script to select and execute a script from the ./lib directory using fzf
#
# # Usage:
# ./main.sh [query]


SCRIPT_DIR="$(script_dir)"
VERSION=$(cat "$ROOT_DIR/version")

# If no args print help
scripts=$( find "$SCRIPT_DIR"/lib -type f -name "main.sh")

if [ -z "$1" ]; then
  echo ""
  echo "Available arguments:"
  echo ""
  echo "    -i, --interactive: Interactive mode"
  echo ""
  for script in $scripts; do
 # print last directory of the script, not the file
 echo "    $(echo "$script" | awk -F'/' '{print $(NF-1)}')"
  done
  exit 1
fi

if [[ "$1" == "-i" || "$1" == "--interactive" ]]; then
  "$SCRIPT_DIR"/lib/interactive.sh
else

  # Loop over scripts and execute one where the filename matches the first arg
  # Exits if no match is found
  for script in $scripts; do
    if [[ "$script" == *"$1"* ]]; then
      bash "$script"
      exit 0
    fi
  done



fi
