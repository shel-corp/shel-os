#!/bin/bash
source "$( dirname "${BASH_SOURCE[0]}")"/bin/dir.sh
source "$ROOT_DIR/bin/utils/fzf.sh"

SCRIPT_DIR="$(script_dir)"
VERSION=$(cat "$ROOT_DIR/version")

# Check if the ./lib directory exists
if [ ! -d "$SCRIPT_DIR/lib" ]; then
  echo "Directory ./lib does not exist."
  exit 1
fi

#Set to first arg or ''
if [ -z "$1" ]; then
  QUERY=""
else
  QUERY="$1"
fi


MENU_HEADER="Tools"
# List all .sh files in the ./lib directory, pipe them into fzf for selection
selected_script=$( find "$SCRIPT_DIR/lib" -type f -name "main.sh" | \
  shel_fzf --query="$QUERY" --header="$MENU_HEADER" --delimiter="/" --with-nth='{-2}' --no-clear
)

# Check if a script was selected
if [ -z "$selected_script" ]; then
  echo "No script selected."
  exit 1
fi

# Execute the selected script
bash "$selected_script"
