#!/bin/bash

# @doc
# A script to run Neovim with a specific configuration.
# Always runs in the shel_os/nvim namespace.
#
# Usage:
# # ./nvim.sh [nvim_options]

source "$( dirname "${BASH_SOURCE[0]}")"/../dir.sh

if [ -x "$NVIM_DIR/bin/nvim" ]; then
  NVIM_APPNAME=shel_os/nvim "$NVIM_DIR/bin/nvim" \
  "$@"
else
    echo "Error: Neovim binary not found at $NVIM_DIR/bin/nvim"
    exit 1
fi
