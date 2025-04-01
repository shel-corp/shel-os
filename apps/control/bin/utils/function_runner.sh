#!/bin/bash

# @doc
# This script allows you to select and run a function from a specified script file.
# It uses fzf for interactive selection and passes any additional arguments to the selected function.
#
# # Usage: ./function_runner.sh <script-file> [<args>...]

source "$( dirname "${BASH_SOURCE[0]}")"/../dir.sh
source "$ROOT_DIR/bin/utils/fzf.sh"

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <script-file> [<args>...]"
  exit 1
fi

# Assign arguments to variables
script_file=$1
shift
args=("$@")

# Check if the script file exists
if [ ! -f "$script_file" ]; then
  echo "File $script_file does not exist."
  exit 1
fi

# List all functions in the script file
functions=$(grep -E '^\s*function\s+\w+' "$script_file" | awk '{print $2}' | sed 's/()//')

# If no functions are found, try another pattern
if [ -z "$functions" ]; then
  functions=$(grep -E '^\s*\w+\s*\(\)' "$script_file" | awk '{print $1}' | sed 's/()//')
fi

# Use fzf to select a function
selected_function=$(echo "$functions" | shel_fzf "$@")

# Check if a function was selected
if [ -z "$selected_function" ]; then
  echo "No function selected."
  exit 1
fi

# Source the script file to make the functions available
source "$script_file"

# Execute the selected function with the provided arguments
$selected_function "${args[@]}"
