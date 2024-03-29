#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
  && . "utils.sh"

create_symlinks() {

  declare -a FILES_TO_SYMLINK=(

    "dotfiles/aliases/bash_aliases"
    "dotfiles/autocomplete/bash_autocomplete"
    "dotfiles/bash_exports"
    "dotfiles/bash_functions"
    "dotfiles/bash_logout"
    "dotfiles/bash_options"
    "dotfiles/bash_profile"
    "dotfiles/bash_prompt"
    "dotfiles/bashrc"
    "dotfiles/curlrc"
    "dotfiles/inputrc"

    "git/gitattributes"
    "git/gitconfig"
    "git/gitignore"

    "tmux/tmux.conf"

    "vim/vim"
    "vim/vimrc"

  )

  local i=""
  local sourceFile=""
  local targetFile=""
  local skipQuestions=false

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  skip_questions "$@" \
    && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in "${FILES_TO_SYMLINK[@]}"; do

      sourceFile="$(cd .. && pwd)/$i"
      targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

      if [ ! -e "$targetFile" ] || $skipQuestions; then

        execute \
          "ln -fs $sourceFile $targetFile" \
          "$targetFile → $sourceFile"

      elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
        print_success "$targetFile → $sourceFile"
      else

        if ! $skipQuestions; then

          ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
          if answer_is_yes; then

            rm -rf "$targetFile"

            execute \
              "ln -fs $sourceFile $targetFile" \
              "$targetFile → $sourceFile"

          else
            print_error "$targetFile → $sourceFile"
          fi

        fi

      fi

    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
  print_in_purple "\n • Create symbolic links\n\n"
  create_symlinks "$@"
}

main "$@"
