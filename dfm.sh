#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if the ./lib directory exists
if [ ! -d "$SCRIPTDIR/lib" ]; then
  echo "Directory ./lib does not exist."
  exit 1
fi

FZF_LABEL=" ShelOS 0.0.1b "
MENU_HEADER="Tools"

#Set to first arg or ''
if [ -z "$1" ]; then
  QUERY=""
else
  QUERY="$1"
fi

# List all .sh files in the ./lib directory, pipe them into fzf for selection
selected_script=$(find "$SCRIPTDIR/lib" -type f -name "main.sh" | \
  fzf --query="$QUERY" --select-1 --border="rounded" --border-label="$FZF_LABEL" --border-label-pos="0" --header="$MENU_HEADER" --delimiter="/" --with-nth='{-2}'
)

# Check if a script was selected
if [ -z "$selected_script" ]; then
  echo "No script selected."
  exit 1
fi

# Execute the selected script
bash "$selected_script"
