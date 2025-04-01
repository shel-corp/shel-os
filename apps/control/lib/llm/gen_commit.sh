#!/bin/bash

# @doc
#
# Generate commit message for staged changes
#
# # Usage:
# ./gen_commit.sh

# @todo
#   - Add support for custom prompt
#   - Track base branch instead of assuming main
#   - Add option to disable caching in config
#   - Add message when cache is used

source "$( dirname "${BASH_SOURCE[0]}")"/../../bin/dir.sh

BRANCH_NAME="$(git branch --show-current)"
LAST_COMMIT="$(git log --format="%H" main.."$BRANCH_NAME" | head -n 1)"
DATA_DIR="$ROOT_DIR/.data/branch-data/$(echo "$BRANCH_NAME" | sed 's/\//-/g')"
FILE="$DATA_DIR"/"$(echo "$LAST_COMMIT" | sed 's/\//-/g')"

if [ ! -d "$DATA_DIR" ]; then
  mkdir -p "$DATA_DIR"
fi

# Check if the file exists and args does not contain --force
if [ -f "$FILE" ]; then
  if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    rm "$FILE"
  else 
   if  [ "$1" != "--view" ] && [ "$1" != "-v" ]; then
    echo "Commit message already generated for $BRANCH_NAME"
    printf "\noptions:\n"
    echo "  --force -f: Regenerate commit message"
    echo "  --view  -v: View commit message without this prompt"
    printf "\n\n"
   fi
    cat "$FILE"
    exit 0
  fi
fi

bash "$BIN_DIR/run/nvim.sh" --headless \
--cmd ":luafile ~/.config/shel_os/nvim/lua/code-companion/hooks.lua" \
-c ":edit $FILE" \
-c "normal! v" \
-c ":CodeCompanion /gen_commit " \
>/dev/null 2>&1

cat "$FILE"

