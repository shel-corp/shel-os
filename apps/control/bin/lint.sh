#!/bin/bash

# @doc
#
# A script to lint all shell scripts in the current directory and its subdirectories.
#
# # Usage:
# ./lint.sh

source "$( dirname "${BASH_SOURCE[0]}")"/dir.sh

SCRIPT_DIR="$(script_dir)"

shellcheck $(find $SCRIPT_DIR -name "*.sh")
