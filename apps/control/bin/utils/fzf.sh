
#!/bin/bash
# 
# A helper function to call fzf with predefined options
#
shel_fzf() {
  SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  ROOTDIR="$(cd $SCRIPTDIR/../.. && pwd)"
  VERSION=$(cat "$ROOTDIR/version")


  # Source the default fzf configuration
  source $ROOTDIR/config/fzf.sh

  fzf "$@"
}
