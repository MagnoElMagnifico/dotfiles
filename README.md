# dotfiles

These are my configuration files for Linux, including:

- [Neovim](https://github.com/neovim/neovim)
- [tmux](https://github.com/tmux/tmux)
- bashrc


# Features

- Minimal
- Fast


# TODO

- Improve `tmux` experience.
- `ZSH`?


# Installation

> **Warning**: This script is experimental. Proceed with caution.

Run the script `install.sh`:

```bash
git clone https://github.com/magnoelmagnifico/dotfiles
cd dotfiles
./install.sh
```

This script will create several symbolic links from this repository to where
each program expects its configuration file, with the `ln -i` flag, so you will
get a prompt in case a file already exists.

Also, the following packages may be downloaded:

- `packer.nvim`: plugin manager for Neovim
