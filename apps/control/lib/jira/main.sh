#!/bin/bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FUNCTION_SCRIPT="$SCRIPTDIR/functions.sh"
ROOTDIR="$(cd $SCRIPTDIR/../.. && pwd)"


MENU_HEADER="Jira tools"
$ROOTDIR/bin/utils/function_runner.sh $FUNCTION_SCRIPT --header="$MENU_HEADER" --no-clear
