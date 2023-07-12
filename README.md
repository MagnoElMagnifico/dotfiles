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
- Integrated python3

[kickstart.nvim]: https://github.com/nvim-lua/kickstart.nvim

## Remember to

Run these commands to get Python3 working (`:py` commands):

```sh
python3 -m pip install pynvim
# or
sudo apt install python3-pynvim
```

And the clipboard support:

```sh
sudo apt install xclip
```

## Mappings

| Mapping                   | Function                                                      |
|:--------------------------|:--------------------------------------------------------------|
| `<Leader>`                | `<Space>`                                                     |
| `+`                       | Cursor to end of line (`$`)                                   |
| `-`                       | Cursor to first non-whitespace character of the line (`^`)    |
| `U`                       | Redo (`<C-r>`)                                                |
| `<C-j>` / `<C-k>`         | Scroll                                                        |
| `<C-Left>` / `<C-Right>`  | Move between tabs                                             |
| `ñ` / `Ñ`                 | Window comand (`<C-w>`)                                       |
| `jk` / `kj`               | Exit insert mode                                              |
| `<Leader>y` / `<Leader>Y` | Yank to system clipboard                                      |
| `<Leader>p` / `<Leader>P` | Paste from system clipboard                                   |
<!-- | `<Leader>p`               | Paste from visual mode without changing the registers         | -->
<!-- | `<Leader>d`               | Delete to void register                                       | -->

Note that I don't use a US keyboard.

Commands:

| Mapping       | Function                                           |
|:--------------|:---------------------------------------------------|
| `<Leader>x`   | Delete current buffer                              |
| `<Leader>w`   | **W**rite current buffer to disk                   |

Netrw (`<Leader>e`):

| Mapping       | Function                                           |
|:--------------|:---------------------------------------------------|
| `<Leader>ee`  | Open **E**xplorer in the current window            |
| `<Leader>et`  | Open **E**xplorer in a new **T**ab                 |
| `<Leader>ev`  | Open **E**xplorer in a **V**ertical split (Left)   |

Comment.nvim (`gc` and `gb`):

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

- `"`: `Hello` to `"Hello"`
- `'`: `Hello` to `'Hello'`, and other characters.
- `{`, `(`, and `[`: `Hello` to `{ Hello }`
- `}`, `)`, and `]`: `Hello` to `{Hello}`
- `>`: `Hello` to `<Hello>`
- `<p>`: `Hello` to `<p>Hello</p>`

Telescope (`<Leader>t`):

| Mapping       | Function                                   |
|:--------------|:-------------------------------------------|
| `<Leader>g`   | Telescope **G**it files                    |
| `<Leader>a`   | Telescope **A**ll files                    |
| `<Leader>ss`  | Telescope **S**earch **S**tring            |
| `<Leader>sw`  | Telescope **S**earch **W**ord under cursor |
| `<Leader>/`   | Telescope search in current buffer         |
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

LSP (`<Leader>l`):

| Mapping      | Function                                                    |
|:-------------|:------------------------------------------------------------|
| `[d` / `]d`  | Go to previous / next **D**iagnostic                        |
| `gl`         | Open diagnostic in floating window (**G**o **L**SP)         |
| `gq`         | Open diagnostics in a quickfix window (**G**o **Q**uickfix) |
| `<Leader>q`  | Open diagnostics in a Telescope window                      |
| `gd`         | **G**o to **D**efinition                                    |
| `gD`         | **G**o to **D**eclaration                                   |
| `gI`         | **G**oto **I**mplementation                                 |
| `gr`         | Telescope **G**oto **R**eferences under cursor              |
| `K`          | Hover documentation for symbol under cursor                 |
| `<Leader>ld` | Open full **D**ocumentation for symbol under cursor         |
| `<Leader>lr` | **R**rename                                                 |
| `<Leader>lc` | **C**ode Action                                             |
| `<Leader>lt` | **T**ype Definition                                         |
| `<Leader>ls` | Telescope Document **S**ymbols                              |
| `<Leader>lw` | Telescope **W**orkspace Symbols                             |

LSP complete (nvim-cmp):

| Mapping               | Function                                       |
|:----------------------|:-----------------------------------------------|
| `i_<C-a>`             | St**a**rt complete menu                        |
| `i_<C-u>` / `i_<C-d>` | Scroll completion docs                         |
| `i_<Enter>`           | Confirm completion                             |
| `i_<Tab>`             | Select next item / go to next field in snippet |

Tree Sitter:

| Mapping   | Type        | Function                       |
|:----------|:------------|:-------------------------------|
| `aa` `ia` | Text object | Parameter                      |
| `af` `if` | Text object | Function                       |
| `ac` `ic` | Text object | Class                          |
| `[m` `]m` | Move        | Previous / Next function start |
| `[M` `]M` | Move        | Previous / Next function end   |
| `[[` `]]` | Move        | Previous / Next class start    |
| `[]` `][` | Move        | Previous / Next class end      |

> **TODO**


## Debugging (with `:Termdebug`)

- `:Termdebug <executable> [<process>]`: start debugging with GDB
- `:Run [<arguments>]`: run program with arguments
- `:Arguments <arguments>`: set arguments for the next `:Run`
- `:Ev[aluate] <expression>`: evaluate expression (`gdb print`)

Breakpoints

- `:Break`: set a breakpoint at the current line; a sign will be displayed
- `:Clear`: delete the breakpoint at the current line

Stepping through code

- `:Step`: execute the gdb "step" command
- `:Over`: execute the gdb "next" command (Next is a Vim command)
- `:Until`: execute the gdb "until" command
- `:Finish`: execute the gdb "finish" command
- `:Continue`: execute the gdb "continue" command
- `:Stop`: interrupt the program

Jump

- `:Gdb`: jump to the gdb window
- `:Program`: jump to the window with the running program
- `:Source `: jump to the window with the source code, create it if there isn't one
- `:Asm`: jump to the window with the disassembly, create it if there isn't one

> Note: from `:help terminal-debug`

Mappings (`<Leader>d`, **D**ebug)

| Mapping       | Function                               |
|:--------------|:---------------------------------------|
| `<Leader>db`  | Set **B**reakpoint on current line     |
| `<Leader>dB`  | Remove **B**reakpoint on current line  |
| `<Leader>n`   | **N**ext                               |
| `<Leader>o`   | Step **O**ver                          |
| `<Leader>du`  | Run **U**ntil cursor                   |
| `<Leader>dc`  | **C**ontinue until next breakpoint     |
| `<Leader>df`  | **F**inish current function            |


## Other commands

- `:Format`: use LSP formatter
- `:Mason`: Manage LSP servers
- `:PackerSync`: update plugins
- `:Git` or `:G`: run git command
- `:Vter [<cmd>]` and `:Hter [<cmd>]` create a terminal and runs a command.
- `:Vpy` and `:Hpy` opens a Python console.

