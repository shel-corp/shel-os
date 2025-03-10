#!/bin/bash

# List all assigned jira issues and associated branches
# Use fzf to select an issue and open or create an associated branch

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FUNCTION_SCRIPT="$SCRIPTDIR/functions.sh"
ROOTDIR="$(cd $SCRIPTDIR/../.. && pwd)"

source $ROOTDIR/lib/git/functions.sh
source $ROOTDIR/lib/jira/functions.sh

# Function to process the list, match the keys to git branches, and return formatted output
#
# Imports: 
#   git/functions.sh.find_branches_for_key
function process_keys_and_branches() {
  while IFS=$'\t' read -r key summary; do
    branches=$(find_branches_for_key "$key")
    if [ -z "$branches" ]; then
      branches="No branches found"
    fi
    # Print key, summary, and branches (handling multiple branches)
    echo -e "$key\t$summary\t$branches"
  done
}

# Generate the summary and process it
#
# Imports: 
#   jira/functions.sh.list_open_issues 
#   
# TODO: Migrate to the local cache strategy
jira_branches() {
  selected=$(list_open_issues | process_keys_and_branches | fzf)

  # Extract the key from the selected output
  key=$(echo "$selected" | awk '{print $1}')

  # Extract the summary from the selected output
  branches=$(echo "$selected" | sed 's/.*\t\(.*\)$/\1/')

#  # If branches are available, checkout the selected branch
 if [[ "$branches" != "No branches found" && "$branches" != "" ]]; then
    branch_count=$(echo "$branches" | tr ',' '\n' | wc -l)
    # If multiple branches are found, use fzf to select one
    if [ "$branch_count" -gt 1 ]; then
      branch_to_checkout=$(echo "$branches" | tr ',' '\n' | fzf)
      git checkout "$branch_to_checkout"
    else
      # If only one branch is found, checkout that branch directly
      git checkout "$(echo "$branches" | tr ',' '\n' | head -n 1)"
    fi
 else
    # If no branch is found, request input for the summary and handle the branch creation
    summary=$(echo "$selected" | tr '[:upper:]' '[:lower:]' | sed 's/^\S*\t\(.*\)\t.*/\1/' | sed 's/ /-/g' | awk '{print $2}')

    # Request input, with the summary pre-populated
    echo "$summary" > ~/.tmp/summary.txt
    vim ~/.tmp/summary.txt  # Make sure to save the file before quitting Vim

    # Use the user input or fallback to the pre-populated summary
    final_summary=$(cat ~/.tmp/summary.txt)
    rm ~/.tmp/summary.txt

    # Create a new branch name by transforming the key and the summary
    new_branch=$(echo "$final_summary-$key" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

    # Create the new branch and checkout
    git checkout -b "$new_branch"
  fi
}

jira_branches
