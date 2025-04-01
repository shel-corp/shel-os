#!/bin/bash

source "$( dirname "${BASH_SOURCE[0]}")"/../../bin/dir.sh

BRANCH_NAME="$(git branch --show-current)"
LAST_COMMIT="$(git log --format="%H" main..$BRANCH_NAME | head -n 1)"
TMP_DIR="$HOME/.tmp"
FILE="$TMP_DIR"/"$(echo "$LAST_COMMIT" | sed 's/\//-/g')"

# Check if the file exists and args does not contain --force
if [ -f $FILE ]; then
  if [ "$1" == "--force" ]; then
    rm "$FILE"
  else
    cat "$FILE"
    exit 0
  fi
fi

bash "$BIN_DIR/run/nvim.sh" -headless \
--cmd ":luafile ~/.config/shel_os/nvim/lua/code-companion/hooks.lua" \
-c ":edit $FILE" \
-c "normal! v" \
-c ":CodeCompanion /gen_commit " \
>/dev/null 2>&1

cat "$FILE"

