#!/bin/bash

# @doc
#
# A script to set permissions for the shel_os project.
#
# Recursively sets read, write, and execute permissions for all files in the project directory.
#
# # Usage:
# ./permissions.sh

source "$( dirname "${BASH_SOURCE[0]}")"/dir.sh

chmod -R +rwx "$ROOT_DIR"
