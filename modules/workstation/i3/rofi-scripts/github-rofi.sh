#!/usr/bin/env bash

USER="hsolrac"

URL="https://github.com/$USER/"

# Clone a repository into the current directory
clone_repository(){
  local repository=$1
  if [ -z "$repository" ]; then
    echo "ERROR: You need to enter the name of the repository you wish to clone."
  else
    git clone "$URL$repository"
  fi
}

# Get all the repositories for the user with curl and GitHub API and filter only
# the repository name from the output with sed substitution
all_my_repositories_short_name(){
  curl -s "https://api.github.com/users/$USER/repos?per_page=1000" | grep -o 'git@[^"]*' |\
    sed "s/git@github.com:$USER\///g"
}

# Rofi dmenu
rofi_dmenu(){
  rofi -dmenu -matching fuzzy -no-custom -p "Select a repository > "\
    -location 0 -bg "#F8F8FF" -fg "#000000" -hlbg "#ECECEC" -hlfg "#0366d6"
}

main(){
  repository=$(all_my_repositories_short_name | rofi_dmenu )
  clone_repository "$repository"
}

main

exit 0
