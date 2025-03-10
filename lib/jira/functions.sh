#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )"
USERNAME=$(jira me)

# Lists all open issues assigned to the user
#   Open issues include any issue with a status of "To Do", "In Progress", "In Code Review", "Ready For QA", or "In QA"
function list_open_issues() {
  query="project IS NOT EMPTY and Assignee = \"$USERNAME\" and (status = 'To Do' or status = 'In Progress' or status = 'In Code Review' or status = 'Ready For QA' or status = 'In QA')"

  jira issue list --plain --columns KEY,SUMMARY \
    -q "$query" \
    | sed '1d' 
}

# Lists the current issue
#
# TODO: Migrate to the local cache strategy
function issue() {
  git rev-parse --abbrev-ref HEAD | awk -F'-' '{print $(NF-1)"-"$NF}' | xargs -t -I{} jira issues view {}
}
