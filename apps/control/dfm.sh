#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOTDIR=$SCRIPTDIR

VERSION=$(cat "$ROOTDIR/version")

# Check if the ./lib directory exists
if [ ! -d "$SCRIPTDIR/lib" ]; then
  echo "Directory ./lib does not exist."
  exit 1
fi

#Set to first arg or ''
if [ -z "$1" ]; then
  QUERY=""
else
  QUERY="$1"
fi

# Source the fzf configuration
source "$ROOTDIR/bin/utils/fzf.sh"

MENU_HEADER="Tools"
# List all .sh files in the ./lib directory, pipe them into fzf for selection
selected_script=$( find "$SCRIPTDIR/lib" -type f -name "main.sh" | \
  shel_fzf --query="$QUERY" --header="$MENU_HEADER" --delimiter="/" --with-nth='{-2}' --no-clear
)

# Check if a script was selected
if [ -z "$selected_script" ]; then
  echo "No script selected."
  exit 1
fi

# Execute the selected script
bash "$selected_script"
