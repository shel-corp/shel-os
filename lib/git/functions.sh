#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FUNCTION_SCRIPT="$SCRIPTDIR/functions.sh"
ROOTDIR="$(cd $SCRIPTDIR/../.. && pwd)"

# Function to find git branches that contain the key (case-insensitive)
function find_branches_for_key() {
  # If no args passed, ask the user for a key
  if [ $# -eq 0 ]; then
    read -p "Enter a key to search for branches: " key
  else
    key=$1
  fi

  local key=$1
  # Get all branches and filter them case-insensitively with grep
  branches=$(git branch --list | grep -i "$key" | sed 's/^..//')  # Clean the output of git branch
  echo "$branches"
}

