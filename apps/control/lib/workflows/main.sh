#!/bin/bash

source "$( dirname "${BASH_SOURCE[0]}")"/../../bin/dir.sh

SCRIPT_DIR="$(script_dir)"
FUNCTION_SCRIPT="$SCRIPT_DIR/functions.sh"

"$ROOT_DIR"/bin/utils/function_runner.sh "$FUNCTION_SCRIPT"
