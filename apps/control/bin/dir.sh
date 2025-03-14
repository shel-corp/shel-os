#!/bin/bash

# @doc
#
# # Helper functions and variables for the shel_os project.
#
# Used to define common paths and configurations.
#
# # Usage:
# source "$( dirname "${BASH_SOURCE[0]}")"/dir.sh

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

VERSION=$(cat "$ROOT_DIR/version")

NVIM_DIR="$ROOT_DIR/deps/nvim"
NVIM_APPNAME=shel_os/nvim

CONFIG_DIR="$ROOT_DIR/config"


function script_dir() {
  echo $(caller 0 | awk '{print $3}' | sed 's|/[^/]*$||')
}
