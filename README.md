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

[kickstart.nvim]: https://github.com/nvim-lua/kickstart.nvim

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

Note that I don't use a US keyboard.

Commands:

| Mapping       | Function                                           |
|:--------------|:---------------------------------------------------|
| `<Leader>x`   | Delete current buffer                              |
| `<Leader>w`   | Write current buffer to disk                       |

Netrw (`<Leader>e`):

| Mapping       | Function                                           |
|:--------------|:---------------------------------------------------|
| `<Leader>ee`  | Open [E]xplorer in the current window              |
| `<Leader>et`  | Open [E]xplorer in a new [T]ab                     |
| `<Leader>ev`  | Open [E]xplorer in a [V]ertical split (Left)       |

Comment.nvim (`gc` and `gb`):

| Mapping          | Function                                     |
|:-----------------|:---------------------------------------------|
| `gcc`            | [C]omment/uncomment current line             |
| `gbc`            | [B]lock [C]omment/uncomment current line     |
| `gc<TextObject>` | [C]omment/uncomment region linewise          |
| `gb<TextObject>` | [C]omment/uncomment region blockwise         |
| `gco`            | Insert comment to the next line              |
| `gcO`            | Insert comment to the previous line          |
| `gcA`            | Insert comment to end of the current line    |

mini.surround:

| Mapping          | Function                                   |
|:-----------------|:-------------------------------------------|
| `sa`             | Add surrounding                            |
| `sr`             | Replace surrounding                        |
| `sd`             | Delete surrounding                         |
| `sf`             | Find surrounding                           |
| `sh`             | Highlight surrounding                      |

These need to be combined with a motion like `w`, `ip`, etc. It also adds the
`n` command which matches the next surrounding. They are also dot-repeatable.

Surroundings:

- `"`: `Hello` to `"Hello"`
- `'`: `Hello` to `'Hello'`, and other characters.
- `{`, `(`, `[` and `<`: `Hello` to `{ Hello }`
- `}`, `)`, `]` and `>`: `Hello` to `{Hello}`
- `t` and enter tag: `Hello` to `<p>Hello</p>`
- `f` and enter name: `Hello` to `function(Hello)`
- `?`: interactive

pinta>fasdfas..fasd

Telescope:

| Mapping        | Function                                   |
|:-------------- |:-------------------------------------------|
| `<Leader>f`    | Search [F]iles                             |
| `<Leader>g`    | [G]rep files                               |
| `<Leader>st`   | [S]earch [T]elescope pickers               |
| `<Leader>s.`   | Repeat last [S]earch                       |
| `<Leader>so`   | [S]earch [O]ld files                       |
| `<Leader>sg`   | [S]earch [G]it files                       |
| `<Leader>sw`   | [S]earch current [W]ord                    |
| `<Leader>sb`   | [S]earch [B]uffers                         |
| `<Leader>sd`   | [S]earch [D]iagnostics                     |
| `<Leader>sh`   | [S]earch [H]elp                            |
| `<Leader>sk`   | [S]earch [K]eymaps                         |
| `<Leader>sm`   | [S]earch [M]aps                            |
| `<Leader>sr`   | [S]earch [R]egisters                       |
| `<Leader>sr`   | [S]earch [R]egisters                       |
| `<Leader>/`    | Grep current buffer                        |
| `<Leader>s/`   | Grep openfiles                             |
| `<Leader>sc`   | [S]earch [C]onfig files                    |

LSP:

| Mapping      | Function                                                    |
|:-------------|:------------------------------------------------------------|
| `[d` / `]d`  | Go to previous / next **D**iagnostic                        |
| `K`          | Hover documentation for symbol under cursor                 |
| `gl`         | Open diagnostic in floating window ([G]o [L]SP)             |
| `gq`         | Open diagnostics in a quickfix window ([G]o [Q]uickfix)     |
| `gd`         | [G]o to [D]efinition                                        |
| `gD`         | [G]o to [D]eclaration (header file)                         |
| `gI`         | [G]o to [I]mplementation                                    |
| `gr`         | [G]o to [R]eferences under cursor                           |
| `<Leader>D`  | Type [D]efinitions                                          |
| `<Leader>q`  | Open diagnostics in a Telescope window                      |
| `<Leader>ds` | [D]ocument [S]ymbols                                        |
| `<Leader>ws` | [W]orkspace [S]ymbols                                       |
| `<Leader>rn` | [R]rename                                                   |
| `<Leader>ca` | [C]ode [A]ction                                             |
| `<Leader>th` | [T]oggle Inlay [H]ints                                      |

LSP complete (nvim-cmp):

| Mapping               | Function                                       |
|:----------------------|:-----------------------------------------------|
| `i_<C-Space>`         | St[a]rt complete menu                          |
| `i_<C-u>` / `i_<C-d>` | Scroll completion docs                         |
| `i_<Enter>`           | Confirm completion                             |
| `i_<C-h>` / `i_<C-l>` | Select next item / go to next field in snippet |

<!-- Tree Sitter:

TODO: Tree sitter text objects

| Mapping   | Type        | Function                       |
|:----------|:------------|:-------------------------------|
| `aa` `ia` | Text object | Parameter                      |
| `af` `if` | Text object | Function                       |
| `ac` `ic` | Text object | Class                          |
| `[m` `]m` | Move        | Previous / Next function start |
| `[M` `]M` | Move        | Previous / Next function end   |
| `[[` `]]` | Move        | Previous / Next class start    |
| `[]` `][` | Move        | Previous / Next class end      | -->

<!-- ## Debugging (with `:Termdebug`)

TODO: Debugging with DAP or Termdebug

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
| `<Leader>df`  | **F**inish current function            | -->


## Other commands

- `:Mason`: Manage LSP servers
- `:Lazy`: Manage plugins
- `:Neogit`
- `:Format`: use LSP formatter
- `:Vter [<cmd>]` and `:Hter [<cmd>]` create a terminal and runs a command.
- `:Vpy` and `:Hpy` opens a Python console.

