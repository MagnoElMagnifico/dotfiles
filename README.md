# dotfiles

These are my configuration files for Linux, including:

- [Neovim](https://github.com/neovim/neovim)
- [tmux](https://github.com/tmux/tmux)
- bashrc


# Installation

> **Warning**: This script is experimental. Proceed with caution.

Run the script `install.sh`:

```bash
git clone https://github.com/magnoelmagnifico/dotfiles
cd dotfiles
./install.sh
```

This script will create several symbolic links from this repository to where
each program expects its configuration file, with the `-i` flag, so you will
get a prompt in case a file already exists.


# Neovim

This configuration is based on [kickstart.nvim].

Features:

- LSP and _Mason_ to manage LSP servers.
- _Tree-Sitter_ with extra text objects.
- _Telescope_
- Git with _vim-fugitive_ and _gitsigns.nvim_
- DAP (work in progress)
- Colorscheme _onedark_ and _lualine.nvim_

[kickstart.nvim]: https://github.com/nvim-lua/kickstart.nvim

## Mappings

| Mapping                  | Function                                                      |
|:-------------------------|:--------------------------------------------------------------|
| `<Leader>`               | `<Space>`                                                     |
| `jk` / `kj`              | Exit insert mode                                              |
| `+`                      | Cursor to end of line (`$`)                                   |
| `-`                      | Cursor to first non-whitespace character of the line (`^`)    |
| `U`                      | Redo (`<C-r>`)                                                |
| `<C-j>` / `<C-k>`        | Scroll                                                        |
| `<C-Left>` / `<C-Right>` | Move between tabs                                             |
| `ñ` / `Ñ`                | Window comand (`<C-w>`)                                       |
| `<Leader>d`              | Delete to void register                                       |
| `<Leader>p`              | Paste from visual mode without changing the registers         |
| `<Leader>y`              | Yank to system clipboard                                      |


Commands:

| Mapping       | Function                                           |
|:--------------|:---------------------------------------------------|
| `<Leader>x`   | Delete current buffer                              |
| `<Leader>w`   | **W**rite current buffer to disk                   |
| `<Leader>n`   | Re**N**ame symbol (under test)                     |
| `<Leader>c`   | Run shell **C**ommand in a vertical split          |
| `<Leader>C`   | Repeat last **C**ommand                            |
| `<Leader>ee`  | Open **E**xplorer in the current window            |
| `<Leader>et`  | Open **E**xplorer in a new **T**ab                 |
| `<Leader>ev`  | Open **E**xplorer in a **V**ertical split (Left)   |

Comment.nvim:

| Mapping          | Function                                     |
|:-----------------|:---------------------------------------------|
| `gcc`            | **C**omment/uncomment current line           |
| `gbc`            | **B**lock **C**omment/uncomment current line |
| `gc<TextObject>` | **C**omment/uncomment region linewise        |
| `gb<TextObject>` | **C**omment/uncomment region blockwise       |
| `gco`            | Insert comment to the next line              |
| `gcO`            | Insert comment to the previous line          |
| `gcA`            | Insert comment to end of the current line    |

Vim-Surround:

| Mapping          | Function                                   |
|:-----------------|:-------------------------------------------|
| `cs<Old><New>`   | **C**hange **S**urrounding                 |
| `ds<Surround>`   | **D**elete **S**urrounding                 |
| `ys<TextObject><Surround>`| Add **S**urrounding               |
| `yss<Surround>`  | Add **S**urrounding to whole **S**entence  |
| `S<Surround>`    | Add **S**urrounding in Visual Mode         |

Surroundings:

- `"`: `Hello` -> `"Hello"`
- `'`: `Hello` -> `'Hello'`, and other characters.
- `{`, `(`, and `[`: `Hello` -> `{ Hello }`
- `}`, `)`, and `]`: `Hello` -> `{Hello}`
- `>`: `Hello` -> `<Hello>`
- `<p>`: `Hello` -> `<p>Hello</p>`

Telescope: 

| Mapping       | Function                                   |
|:--------------|:-------------------------------------------|
| `<Leader>g`   | Telescope **G**it files                    |
| `<Leader>a`   | Telescope **A**ll files                    |
| `<Leader>ss`  | Telescope **S**earch **S**tring            |
| `<Leader>sw`  | Telescope **S**earch **W**ord under cursor |
| `<Leader>r`   | Telescope show **R**egisters               |
| `<Leader>b`   | Telescope show **B**uffers                 |
| `<Leader>m`   | Telescope show **M**arks                   |
| `<Leader>to`  | **T**elescope **O**ld files                |
| `<Leader>ts`  | **T**elescope **S**ell suggest             |
| `<Leader>tm`  | **T**elescope **M**anpages                 |
| `<Leader>th`  | **T**elescope **H**elp tags                |
| `<Leader>tgs` | **T**elescope **G**it **S**tatus           |
| `<Leader>tgc` | **T**elescope **G**it **C**ommits          |
| `<Leader>tgb` | **T**elescope **G**it **B**ranches         |
| `<Leader>tt`  | **T**elescope all pickers                  |

LSP:

> **TODO**

Tree Sitter:

> **TODO**

