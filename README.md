# dotfiles

These are my configuration files for Linux, including:

- [Neovim](https://github.com/neovim/neovim)
- [Awesome](https://github.com/awesomeWM/awesome)
- [tmux](https://github.com/tmux/tmux)

# Features

- Minimal 
- Fast

# Installation

> **Warning**: This script is experimental and is not working properly yet

Run the script `install.sh`:

```
git clone https://github.com/magnoelmagnifico/dotfiles
cd dotfiles
./install.sh
```

This script will create several symbolic links where each program expects its
configuration file with the `ln -i` flag, so you will get a prompt.

Also, the following packages may be downloaded:

- `packer.nvim`: plugin manager for Neovim
