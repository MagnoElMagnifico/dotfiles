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

echo
echo SCRIPT: $SCRIPT
echo DOTFILES_DIR: $DOTFILES_DIR
echo CONFIG_DIR: $CONFIG_DIR
echo

if [[ -z $XDG_CONFIG_HOME ]]; then
    printf "XDG_CONFIG_HOME variable not found.\n"
    read -p "Default is $CONFIG_DIR. Want to change it? [y/N]: " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        while
	    read -p "Input new config directory: " -r;
	    [[ -z $REPLY || ! -d $REPLY ]]
	do printf "Please, input a valid path\n\n"; done
	CONFIG_DIR=$REPLY
    fi
else
    CONFIG_DIR=$XDG_CONFIG_HOME
fi

# Neovim
ln -s $DOTFILES_DIR/nvim $CONFIG_DIR/nvim
printf "Neovim config installed successfully\n\n"

# Tmux
ln -s $DOTFILES_DIR/tmux.conf $HOME/.tmux.conf
printf "tmux config installed successfully\n\n"

#### git config ####
read -p "Want to configure git? [y/N]: " -n 1 -r; echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [[ -x $(command -v git) ]]; then
        # TODO: Check if already set
        read -p "Input git username: " git_username
        read -p "Input git email: " git_email
    
        printf "Setting up git profile... "
    
        git config --global user.email "$git_email"
        git config --global user.name "$git_username"

        # TODO: Add github password?
        printf "Done.\n\n"
    else
        printf "Git is not installed or it is not on the path.\n\n"
    fi
fi
