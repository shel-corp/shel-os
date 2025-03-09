#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FUNCTION_SCRIPT="$SCRIPTDIR/functions.sh"
ROOTDIR="$(cd $SCRIPTDIR/../.. && pwd)"


$ROOTDIR/bin/utils/function_runner.sh $FUNCTION_SCRIPT
