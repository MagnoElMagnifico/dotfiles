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

# Neovim
ln -s $PWD/nvim ~/.config

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
