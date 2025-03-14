#!/bin/bash

# @doc
# A helper function to call fzf with predefined options
#
# Usage:
# # shel_fzf [fzf_options]

source "$( dirname "${BASH_SOURCE[0]}")"/../dir.sh

shel_fzf() {
  # Source the default fzf configuration
  source $ROOTDIR/config/fzf.sh

  fzf "$@"
}
