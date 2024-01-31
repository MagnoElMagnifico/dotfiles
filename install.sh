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

# Helix
printf "[+] helix: dotfiles/helix -> ~/.config/helix\n"
create_link $DOTFILES_DIR/helix $HOME/.config/helix

# VSCodium
#printf "[+] VSCodium: dotfiles/VSCodium/settings.json -> ~/.config/VSCodium/User/settings.json\n"
#create_link $DOTFILES_DIR/VSCodium/settings.json $HOME/.config/VSCodium/User/settings.json

# Neovim
printf "[+] Neovim: dotfiles/nvim -> ~/.config/nvim\n"
create_link $DOTFILES_DIR/nvim $HOME/.config/nvim

if [[ $? == 0 ]]; then
    printf "    Packer.nvim...\n"

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
    else
        printf "    Git is not installed\n"
    fi
fi

#### git config ####
if [[ -x $(command -v git) ]]; then
    read -p "Want to configure git now? [y/N]: " -n 1 -r; echo

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        # TODO: Check if already set
        read -p "Input git username: " git_username
        read -p "Input git email: " git_email

        printf "[+] Setting up git profile... "

        git config --global user.email "$git_email"
        git config --global user.name "$git_username"
        git config --global credential.helper store

        printf "Done.\n\n"
    fi
fi
