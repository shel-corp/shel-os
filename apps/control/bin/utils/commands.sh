#!/bin/bash

# @doc
#
# Parses command-line flags and executes corresponding functions.
#
# # Usage:
# parse_flags "$@"
#
# This function iterates through the command-line arguments, checks if they are registered flags, and executes the corresponding function.
# If a flag requires an argument, it consumes the next argument and passes it to the function.
# If no flags are provided, and a default function is set, it executes the default function.


parse_flags() {
  while [[ $# -gt 0 ]]; do
    key="$1"
    # Check if the flag is registered
    if [[ -v flag_data[$key] ]]; then
      # Extract the function name and argument requirement from the flag data
      local function_info="${flag_data[$key]}"
      local help_text=$(echo "$function_info" | cut -d'|' -f1)
      local exec_function=$(echo "$function_info" | cut -d'|' -f2)
      local requires_arg=$(echo "$function_info" | cut -d'|' -f3)

      shift

      # Check if the flag requires an argument
      if [[ "$requires_arg" == "true" ]]; then
        if [[ $# -gt 0 ]]; then
          local arg="$1"
          shift
          "$exec_function" "$arg"
        else
          echo "Error: Flag '$key' requires an argument, but none was provided." >&2
          return 1
        fi
      else
        "$exec_function"
      fi

      return
    else
      echo "Error: Unrecognized flag '$key'. Use --help for usage information." >&2
      return 1
    fi
  done
}

