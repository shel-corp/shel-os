#!/bin/bash
# 
# An fzf configuration
# 
# Theme generator: https://vitormv.github.io/fzf-themes/
#
# fzf configuration:
#
# --query="$QUERY" : Pre-fill the search query with the value of $QUERY
# --select-1 : Automatically select the only match if there's only one
# --border="rounded" : Use rounded borders for the fzf interface
# --border-label="$FZF_LABEL" : Set the label for the border with the value of $FZF_LABEL
# --border-label-pos="0" : Position the border label at the center of the top border
# --header="$MENU_HEADER" : Set the header of the fzf interface with the value of $MENU_HEADER
# --delimiter="/" : Use '/' as the delimiter for the fields
# --with-nth='{-2}' : Display only the second-to-last field in the fzf interface
#
# see `$ man fzf` for more information
FZF_LABEL=" $VERSION "
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --border-label="'$FZF_LABEL'" 
  --color=prompt:-1,spinner:-1,pointer:-1,header:-1
  --select-1
  --border="rounded"
  --border-label-pos="0"
  '

#  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
#  --color=border:#262626,label:#aeaeae,query:#d9d9d9
#  --border="rounded" --border-label="foo" --border-label-pos="0" --preview-window="border-sharp"
#  --prompt="> " --marker=">" --pointer="◆" --separator=""
#  --scrollbar="│"'
