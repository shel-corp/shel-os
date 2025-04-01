#!/bin/bash

# @doc
#
# # A script containing various graphQL queries for the gh cli
#
# # Usage:
# # # source queries.sh 

function my_repos(){
  # list all repositories for the current user
  echo "
    query(\$endCursor: String) {
      viewer {
        repositories(first: 100, after: \$endCursor) {
          nodes { nameWithOwner }
          pageInfo {
            hasNextPage
            endCursor
          }
        }
      }
    }
  "
}

#gh api graphql --paginate -f query="$(my_repos)" | jq -r '.data.viewer.repositories.nodes[].nameWithOwner'
