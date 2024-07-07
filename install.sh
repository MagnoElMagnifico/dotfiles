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

# $1 source file/directory
# $2 destination file (if source is a file)
#                parent directory (if the source is a directory)
function create_link {
    read -e -p "    Create link? [y/N] "
    if ! [[ "$REPLY" == [Yy]* ]]; then
        return 1
    fi

    # Check if already exists
    if [ -e $2 ]; then
        printf "    $2 already exists, want to overwrite? "
        read -e -p '[y/N] '

        if [[ "$REPLY" == [Yy]* ]]; then
            # ln cannot overwrite directories
            if [ -d $2 ]; then
                rm --dir $2
            fi
            ln -sf $1 $2
        fi
    else
        ln -s $1 $2
    fi

    return 0
}

SCRIPT=$(realpath "$0")
DOTFILES_DIR=$(dirname "$SCRIPT")

# User dirs
printf "[+] User dirs: dotfiles/user-dirs.dirs -> ~/.config/user-dirs.dirs\n"
create_link $DOTFILES_DIR/user-dirs.dirs $HOME/.config/user-dirs.dirs

# Bashrc
printf "[+] bashrc: dotfiles/bashrc -> ~/.bashrc\n"
create_link $DOTFILES_DIR/bashrc $HOME/.bashrc

# Tmux
printf "[+] tmux: dotfiles/tmux.conf -> ~/.tmux.conf\n"
create_link $DOTFILES_DIR/tmux.conf $HOME/.tmux.conf

# # Helix
# printf "[+] helix: dotfiles/helix -> ~/.config/helix\n"
# create_link $DOTFILES_DIR/helix $HOME/.config/helix

# # VSCodium
# printf "[+] VSCodium: dotfiles/VSCodium/settings.json -> ~/.config/VSCodium/User/settings.json\n"
# create_link $DOTFILES_DIR/VSCodium/settings.json $HOME/.config/VSCodium/User/settings.json

# Neovim
printf "[+] Neovim: dotfiles/nvim -> ~/.config/nvim\n"
create_link $DOTFILES_DIR/nvim $HOME/.config/nvim

# Git
printf "[+] Neovim: dotfiles/nvim -> ~/.config/nvim\n"
create_link $DOTFILES_DIR/gitconfig $HOME/.gitconfig
