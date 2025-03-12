#!/bin/bash

# Used to query a yaml file for a specific field.
#
# # Usage:
# # fetch_field.sh <yaml-file> <root-key> <field-name> [<field-name> ...]
#
# # Example:
# #
# # SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../.. && pwd )"
# #
# # USERNAME=$(
# #   eval echo $($SCRIPTDIR/bin/utils/fetch_field.sh $SCRIPTDIR/.conf.yaml jira username)
# # )


# Check if the correct number of arguments is provided
if [ "$#" -lt 3 ]; then
  echo "Usage: $0 <yaml-file> <root-key> <field-name> [<field-name> ...]"
  exit 1
fi

# Assign arguments to variables
yaml_file=$1
root_key=$2
shift 2
fields=("$@")

# Construct the yq expression
yq_expression=".. | select(has(\"$root_key\")) | .$root_key[]"
for field in "${fields[@]}"; do
  yq_expression+=" | select(has(\"$field\")) | .$field"
done

# Use yq to extract the specified fields under the root key
yq e "$yq_expression" "$yaml_file"
