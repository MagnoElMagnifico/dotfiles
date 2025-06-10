#!/bin/bash

cat << EOF
      _       _    __ _ _
     | |     | |  / _(_) |
   __| | ___ | |_| |_ _| | ___  ___
  / _  |/ _ \| __|  _| | |/ _ \/ __|
 | (_| | (_) | |_| | | | |  __/\__ \\
(_)__,_|\___/ \__|_| |_|_|\___||___/

By Magno El Magnífico

EOF

# $1 Program name
# $2 src: file/directory
# $3 dst: file (if source is a file)
#         parent directory (if the source is a directory)
function create_link {
    printf     "[+] $1: $2 -> $3\n"
    read -e -p "    Create link? [y/N] "
    if ! [[ "$REPLY" == [Yy]* ]]; then
        return 1
    fi

    # Check if already exists
    if [ -e $3 ]; then
        read -e -p "    $2 already exists, want to overwrite? [y/N] "

        if [[ "$REPLY" == [Yy]* ]]; then
            # ln cannot overwrite directories
            if [ -d $3 ]; then
                rm --dir $3
            fi
            ln -sf $2 $3
        else
            printf "Skipping..."
        fi
    else
        ln -s $2 $3
    fi

    return 0
}

SCRIPT=$(realpath "$0")
DOTFILES_DIR=$(dirname "$SCRIPT")

create_link "User dirs" $DOTFILES_DIR/user-dirs.dirs $HOME/.config/user-dirs.dirs
create_link "bashrc"    $DOTFILES_DIR/bash/bashrc    $HOME/.bashrc
create_link "profile"   $DOTFILES_DIR/bash/profile   $HOME/.profile
create_link "Neovim"    $DOTFILES_DIR/nvim           $HOME/.config/nvim
create_link "Git"       $DOTFILES_DIR/gitconfig      $HOME/.gitconfig
create_link "tmux"      $DOTFILES_DIR/tmux.conf      $HOME/.tmux.conf
create_link "Wezterm"   $DOTFILES_DIR/wezterm        $HOME/.config/wezterm

# create_link "Helix"     $DOTFILES_DIR/helix          $HOME/.config/helix
# create_link "VS Codium" $DOTFILES_DIR/VSCodium/settings.json $HOME/.config/VSCodium/User/settings.json
