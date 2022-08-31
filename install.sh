#!/bin/bash

# Exit on errors
set -e

cat << EOF
      _       _    __ _ _           
     | |     | |  / _(_) |          
   __| | ___ | |_| |_ _| | ___  ___ 
  / _  |/ _ \| __|  _| | |/ _ \/ __|
 | (_| | (_) | |_| | | | |  __/\__ \\
(_)__,_|\___/ \__|_| |_|_|\___||___/

By Magno El Magnífico

EOF

SCRIPT=$(realpath "$0")
DOTFILES_DIR=$(dirname "$SCRIPT")
CONFIG_DIR="$HOME/.config"

if [[ -z $XDG_CONFIG_HOME ]]; then
    printf "XDG_CONFIG_HOME variable not found.\n\n"
else
    CONFIG_DIR=$XDG_CONFIG_HOME
fi

read -p "Default is $CONFIG_DIR. Want to change it? [y/N]: " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    while
        read -p "Input new config directory: " -r;
        [[ -z $REPLY || ! -d $REPLY ]]
    do printf "Please, input a valid path\n\n"; done
    CONFIG_DIR=$REPLY
fi

printf "Installing config...\n"

# Neovim
printf "[+] Neovim dotfiles/nvim -> $CONFIG_DIR/nvim... "
    ln -s $DOTFILES_DIR/nvim $CONFIG_DIR/nvim
printf "Done.\n"

# Tmux
printf "[+] Neovim dotfiles/tmux.conf -> ~/.tmux.conf... "
    ln -s $DOTFILES_DIR/tmux.conf $HOME/.tmux.conf
printf "Done.\n"

#### git config ####
if [[ -x $(command -v git) ]]; then
    read -p "Want to configure git? [y/N]: " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # TODO: Check if already set
        read -p "Input git username: " git_username
        read -p "Input git email: " git_email
    
        printf "[+] Setting up git profile... "
    
        git config --global user.email "$git_email"
        git config --global user.name "$git_username"

        # TODO: Add github password?
        printf "Done.\n\n"
    else
        printf "Git is not installed or it is not on the path.\n\n"
    fi
fi
