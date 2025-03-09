#!/bin/bash

# Check if the ./lib directory exists
if [ ! -d "./lib" ]; then
  echo "Directory ./lib does not exist."
  exit 1
fi

# List all .sh files in the ./lib directory, pipe them into fzf for selection
selected_script=$(find ./lib -type f -name "*.sh" | fzf)

# Check if a script was selected
if [ -z "$selected_script" ]; then
  echo "No script selected."
  exit 1
fi

# Execute the selected script
bash "$selected_script"
