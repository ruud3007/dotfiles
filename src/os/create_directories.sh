#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_directories() {
  declare -a DIRECTORIES=(
    "$HOME/Documents/personal"
    "$HOME/Documents/personal/bad"
    "$HOME/Documents/personal/bad/codes"
    "$HOME/Documents/personal/bad/designs"
    "$HOME/Documents/personal/bad/documents"
    "$HOME/Documents/personal/bad/images"
    "$HOME/Documents/personal/bad/sheets"
    "$HOME/Documents/personal/documents"
    "$HOME/Documents/personal/ebooks"
    "$HOME/Documents/personal/learning"
    "$HOME/Documents/personal/photos"
    "$HOME/Documents/screenshots"
    "$HOME/Documents/work"
    "$HOME/Documents/work/codes"
    "$HOME/Documents/work/designs"
    "$HOME/Documents/work/documents"
    "$HOME/Documents/work/images"
    "$HOME/Documents/work/sheets"
  )

  for i in "${DIRECTORIES[@]}"; do
    mkd "$i"
  done
}

main() {
  print_in_purple "\n • Create directories\n\n"
  create_directories
}

main
