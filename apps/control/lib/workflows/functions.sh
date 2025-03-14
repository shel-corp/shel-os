#!/bin/bash

source "$( dirname "${BASH_SOURCE[0]}")"/../../bin/dir.sh

SCRIPT_DIR="$(script_dir)"

function jira_branches() {
  source "$SCRIPT_DIR"/jira_branches.sh
}

function exit() {
  clear
}
