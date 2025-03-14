#!/bin/bash
source "$( dirname "${BASH_SOURCE[0]}")"/../dir.sh

if [ -f "$HOME/.gitconfig" ]; then
  GIT_NAME=$(grep -m 1 "name = " "$HOME/.gitconfig" | cut -d' ' -f3-)
else
  GIT_NAME=0
fi

