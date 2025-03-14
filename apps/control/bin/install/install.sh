#!/bin/bash

# @doc
#
# Installs dependencies for the shel_os project.
#
# # Usage:
# # # ./install.sh

source "$( dirname "${BASH_SOURCE[0]}")"/../dir.sh

SCRIPT_DIR=$(script_dir)


mkdir $ROOT_DIR/.tmp

$SCRIPT_DIR/nvim.sh

rm -rf $ROOTDIR/.tmp
