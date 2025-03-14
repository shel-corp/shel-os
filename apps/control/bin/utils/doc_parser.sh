#!/bin/bash

# @doc
# Used to parse @doc tags in shell scripts. 
#
# Usage:
# # parse_doc <script_file>

#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <script-file>"
  exit 1
fi

in_doc_tag=0

while IFS= read -r line; do
  if [[ "$line" =~ ^"# @doc" ]]; then
    in_doc_tag=1
  elif [[ $in_doc_tag -eq 1 ]]; then
    if [[ "$line" =~ ^"#" ]]; then
      echo "${line:2}"
    else
      in_doc_tag=0
    fi
  fi
done < "$1"

