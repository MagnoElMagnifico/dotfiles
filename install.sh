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

printf "Installing config...\n"

# Bashrc
printf "[+] Bashrc: dotfiles/bashrc -> ~/.bashrc\n"
ln -si $DOTFILES_DIR/bashrc $HOME/.bashrc
printf "Done.\n\n"

# Tmux
printf "[+] tmux: dotfiles/tmux.conf -> ~/.tmux.conf\n"
ln -si $DOTFILES_DIR/tmux.conf $HOME/.tmux.conf
printf "Done.\n\n"

# Neovim
printf "[+] Neovim: dotfiles/nvim -> ~/.config/nvim\n"

if [[ ! -d $HOME/.config ]]
    then mkdir $HOME/.config
fi

ln -si $DOTFILES_DIR/nvim $HOME/.config

printf "Done.\nPacker.nvim...\n"

if [[ -x $(command -v git) ]]; then
    # From its README file
    packer_path="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"

    if [[ -d $packer_path ]] && [[ ! -z "$(ls -A $packer_path)" ]]; then
        printf "Directory not empty. Atempting to pull changes... \n"
        printf "==== GIT PULLING ==================================\n"
        cd $packer_path && git pull || printf "ERROR\n"
        cd -
        printf "===================================================\n"
    else
        printf "==== GIT CLONING ==================================\n"
        git clone --depth 1 https://github.com/wbthomason/packer.nvim $packer_path
        printf "===================================================\n"
    fi

    printf "\nFinished installation\n\n"

    #### git config ####
    read -p "Want to configure git now? [y/N]: " -n 1 -r; echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # TODO: Check if already set
        read -p "Input git username: " git_username
        read -p "Input git email: " git_email
    
        printf "[+] Setting up git profile... "
    
        git config --global user.email "$git_email"
        git config --global user.name "$git_username"

        # TODO: Add github password?
        printf "Done.\n\n"
    fi
else
    printf "Git is not installed or it is not on the path.\n\n"
fi
