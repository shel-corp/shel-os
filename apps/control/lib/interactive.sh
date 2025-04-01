#!/bin/bash
source "$( dirname "${BASH_SOURCE[0]}")"/../bin/dir.sh
source "$ROOT_DIR/bin/utils/fzf.sh"

# @doc
#
# A script to select and execute a script from the directory using fzf
#
# # Usage:
# ./main.sh [query]

SCRIPT_DIR="$(script_dir)"
VERSION=$(cat "$ROOT_DIR/version")

#Set to first arg or ''
if [ -z "$1" ]; then
  QUERY=""
else
  QUERY="$1"
fi


MENU_HEADER="Tools"
doc_parser="$ROOT_DIR/bin/utils/doc_parser.sh"

selected_script=$( find "$SCRIPT_DIR" -type f -name "main.sh" | \
  shel_fzf --query="$QUERY" --header="$MENU_HEADER" --delimiter="/" --with-nth='{-2}' --no-clear \
  --preview="bash $doc_parser {}" \
)

# Check if a script was selected
if [ -z "$selected_script" ]; then
  echo "No script selected."
  exit 1
fi

# Execute the selected script
bash "$selected_script"
