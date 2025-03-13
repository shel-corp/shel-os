#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )"

echo "$ROOTDIR"

mkdir $ROOTDIR/.tmp

$SCRIPTDIR/nvim.sh

rm -rf $ROOTDIR/.tmp
