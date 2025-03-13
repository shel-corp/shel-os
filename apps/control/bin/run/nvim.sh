#!/bin/bash

ROOTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && realpath . )"
NVIM_DIR="$ROOTDIR/deps/nvim"
CONFIG_DIR="$ROOTDIR/config/nvim"
PLUGIN_DIR="$CONFIG_DIR/plugins/codecompanion.nvim"

NVIM_APP_NAME=shel_os

# if --debug is passed, set the debug flag
if [[ "$1" == "--setup" ]]; then
  NVIM_APPNAME=shel_os/nvim "$NVIM_DIR/bin/nvim" -u $CONFIG_DIR/lua/setup.lua \
  exit 1
fi

if [ -x "$NVIM_DIR/bin/nvim" ]; then
  NVIM_APPNAME=shel_os/nvim "$NVIM_DIR/bin/nvim" \
  # --cmd ":luafile $CONFIG_DIR/set_path.lua" \
  "$@"
  #-c ":PlugInstall" \
else
    echo "Error: Neovim binary not found at $NVIM_DIR/bin/nvim"
    exit 1
fi
