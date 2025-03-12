#!/bin/bash

echo "Verifying installation of dependencies..."

not_installed=()
required=("make" "nvim" "git" "fzf" "jira" "cat" "curl" "rg" "fd" "bat" "gh")

for req in "${required[@]}"; do
    if ! command -v $req &> /dev/null; then
        echo "$req is not installed."
        not_installed+=($req)
    fi
done

if [ ${#not_installed[@]} -eq 0 ]; then
    echo "All dependencies are installed."
else
    echo "The following dependencies are missing: ${not_installed[@]}"
fi

# Run shellcheck recursively on all .sh files in the current directory
find . -name "*.sh" -exec shellcheck {} \;

