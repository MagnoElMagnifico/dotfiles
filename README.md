# dotfiles

These are my configuration files for Linux, including:

- My user directories
- [Neovim](https://github.com/neovim/neovim)
- [wezterm](https://wezfurlong.org/wezterm/)
- bashrc
- Git

And other tools that I use sometimes:

- [tmux](https://github.com/tmux/tmux)
- [Helix](https://helix-editor.com/)
- [VS Codium](https://vscodium.com)


# Installation

> **Warning**: This script is experimental. Proceed with caution.

Run the script `install.sh`:

```bash
git clone https://github.com/magnoelmagnifico/dotfiles
cd dotfiles
./install.sh
```

This script will create several symbolic links from this repository to where
each program expects its configuration file.


# Neovim

This configuration is based on [kickstart.nvim].

[kickstart.nvim]: https://github.com/nvim-lua/kickstart.nvim

## Mappings

| Mapping                   | Function                                                      |
|:--------------------------|:--------------------------------------------------------------|
| `<Leader>`                | `<Space>`                                                     |
| `+`                       | Cursor to end of line (`$`)                                   |
| `-` / `&`                 | Cursor to first non-whitespace character of the line (`^`)    |
| `U`                       | Redo (`<C-r>`)                                                |
| `<C-j>` / `<C-k>`         | Scroll                                                        |
| `<C-Left>` / `<C-Right>`  | Move between tabs                                             |
| `ñ` / `Ñ` / `;`           | Window comand (`<C-w>`)                                       |
| `jk` / `kj`               | Exit insert mode                                              |
| `<Leader>y` / `<Leader>Y` | Yank to system clipboard                                      |
| `<Leader>p` / `<Leader>P` | Paste from system clipboard                                   |
| `<Leader>x`               | Delete current buffer                                         |
| `<Leader>w`               | Write current buffer to disk                                  |

Opening the file explorer (Netrw - `<Leader>e`):

| Mapping       | Function                                              |
|:--------------|:------------------------------------------------------|
| `<Leader>ee`  | Open [E]xplorer in the current window (open file)     |
| `<Leader>ec`  | Like before but opens the [C]urrent Working Directory |
| `<Leader>et`  | Open [E]xplorer in a new [T]ab                        |
| `<Leader>ev`  | Open [E]xplorer in a [V]ertical split (Left)          |

Navigating in the file explorer:

| Mapping            | Function                                                 |
|:-------------------|:---------------------------------------------------------|
| `cd`               | Make browsing directory the working directory            |
| `-`                | Go up one directory                                      |
| `i`                | Listing: Thin - Long - Wide - Tree                       |
| `s`                | Sort by: Name - Time - File size                         |
| `S`                | Specify suffix prioriry for sorting                      |
| `d`                | Create a directory                                       |
| `%`                | Create a file                                            |
| `D`                | [D]elete file under cursor  (works in `V` mode)          |
| `R`                | [R]ename or move file                                    |
| `<Enter>`          | Open file                                                |
| `v`                | Open file in a vertical split                            |
| `o`                | Open file in a horizontal split                          |
| `t`                | Open file in a new tab                                   |
| `p`                | Preview the file in a new horizontal split               |
| `gp`               | Change file [p]ermission                                 |
| `mf` / `mr`        | Mark file / Mark files using regex                       |
| `mF` / `mu`        | Unmark file / Unmark all                                 |
| `mt` / `:MF <dir>` | Set target directory (directory under cursor or current) |
| `mm`               | Move marked files to target directory                    |
| `mc`               | Copy marked files to target directory                    |
| `mx`               | Apply shell command to files                             |

Remember:

- `:pwd`: to show the current working directory of neovim.
- `:cd %`: to change the current working directory. `%` specifies the current
  file.

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

Telescope (`<Leader>s` - [S]earch):

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
| `<Leader>s/`   | Grep open files                            |
| `<Leader>sc`   | [S]earch [C]onfig files                    |

LSP (`<Leader>l` - [L]SP):

| Mapping      | Function                                                    |
|:-------------|:------------------------------------------------------------|
| `[d` / `]d`  | Go to previous / next [D]iagnostic                          |
| `K`          | Hover documentation for symbol under cursor                 |
| `gl`         | Open diagnostic in floating window ([G]o [L]SP)             |
| `gq`         | Open diagnostics in a quickfix window ([G]o [Q]uickfix)     |
| `gd`         | [G]o to [D]efinition                                        |
| `gD`         | [G]o to [D]eclaration (header file)                         |
| `gI`         | [G]o to [I]mplementation                                    |
| `gr`         | [G]o to [R]eferences under cursor                           |
| `<Leader>lt` | [T]ype Definition                                           |
| `<Leader>ll` | Open [d]iagnostics in a Telescope window                    |
| `<Leader>ld` | [D]ocument Symbols                                          |
| `<Leader>lw` | [W]orkspace Symbols                                         |
| `<Leader>lr` | [R]ename                                                    |
| `<Leader>la` | Code [A]ction                                               |
| `<Leader>li` | Toggle [I]nlay Hints                                        |
| `<Leader>lf` | Show [F]unction signature                                   |

LSP complete (nvim-cmp):

| Mapping               | Function                                       |
|:----------------------|:-----------------------------------------------|
| `i_<C-Space>`         | Start complete menu                            |
| `i_<C-u>` / `i_<C-d>` | Scroll completion docs ([U]p and [D]own)       |
| `i_<Enter>`           | Confirm completion                             |
| `i_<C-h>` / `i_<C-l>` | Select next item / go to next field in snippet |

Tree sitter text objects:

| Mapping   | Type        | Function                       |
|:----------|:------------|:-------------------------------|
| `aa` `ia` | Text object | Parameter                      |
| `af` `if` | Text object | Function call                  |
| `ac` `ic` | Text object | Class                          |
| `[m` `]m` | Move        | Previous / Next function start |
| `[M` `]M` | Move        | Previous / Next function end   |
| `[[` `]]` | Move        | Previous / Next class start    |
| `[]` `][` | Move        | Previous / Next class end      |

Debugging with DAP (`<Leader>d` - [D]ebug):

| Mapping          | Function                          |
|:-----------------|:----------------------------------|
| `<F9>` / `<F10>` | Start / Finish                    |
| `<F11>`          | Toggle UI                         |
| `<F1>`           | Step into function call           |
| `<F2>`           | Step over to the next sentence    |
| `<F3>`           | Step out of function              |
| `<F4>`           | Run to cursor                     |
| `<F5>`           | Step back (step into reversed)    |
| `<F6>`           | Reverse continue until breakpoint |
| `<Leader>b`      | Toggle [b]reakpoint               |
| `<Leader>B`      | Create conditional [b]reakpoint   |
| `<Leader>dl`     | Set [l]og breakpoint              |
| `<Leader>db`     | List [b]reakpoints                |
| `<Leader>dB`     | Remove all the [b]reakpoints      |
| `<Leader>dh`     | [H]over expression                |
| `<Leader>dj`     | [J]ump to current frame           |
| `<Leader>dc`     | Open interactive [c]onsole        |

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

Managers:

- `:Mason`: Manage LSP servers
- `:Lazy`: Manage plugins
- `:ConformInfo`: Manage formatters

Others:

- `:Neogit` (or `<Leader>G`)
- `:Vter [<cmd>]` and `:Hter [<cmd>]` create a terminal and runs a command.
- `:Vpy` and `:Hpy` opens a Python console.


# WezTerm

Tabs:

| Mapping           | Function   |
|:------------------|:-----------|
| `Alt-t`           | New tab    |
| `Alt-w`           | Close tab  |
| `Alt-1` ... `9`   | Select tab |
| `Alt-[` / `Alt-]` | Switch tab |
| `Alt-{` / `Alt-}` | Move tabs  |
| `Alt-.`           | Last tab   |

Panes:

| Mapping                   | Function               |
|:--------------------------|:-----------------------|
| `Alt-v`                   | Split [v]ertically     |
| `Alt-b`                   | Split horizontally     |
| `Alt-x`                   | Close pane             |
| `Alt-z` / `Alt-Enter`     | Toggle [z]oom          |
| `Alt-hjkl` / `Alt-Arrows` | Switch pane            |
| `Alt-s`                   | [S]elect pane          |
| `Alt-m`                   | [M]ove panes clockwise |
| `Alt-S`                   | [S]wap two panes       |
| `Alt-T`                   | Send pane to new [T]ab |

Resize pane mode:

| Mapping            | Function                      |
|:-------------------|:------------------------------|
| `Alt-r`            | Init resize mode              |
| `hjkl`             | Resize pane                   |
| `Arrows`           | Resize pane with more control |
| `Escape` / `Enter` | Exit resize mode              |

Search mode:

| Mapping                        | Function                                                         |
|:-------------------------------|:-----------------------------------------------------------------|
| `Alt-f`                        | Init search mode                                                 |
| `Enter` / `Ctrl-p` / `UpArrow` | Search previous                                                  |
| `Ctrl-n` / `DownArrow`         | Search next                                                      |
| `Ctrl-r`                       | Change search mode (Case sensitive - Case insensitive - [R]egex) |
| `Ctrl-u`                       | Clear pattern                                                    |
| `Escape` / `Ctrl-c`            | Exit search mode                                                 |

Copy mode:

- `Alt-c`: Init [c]opy mode
- [WezTerm defaults](https://wezfurlong.org/wezterm/copymode.html#key-assignments)
- Vim-like movement
- Copy with `y` and exit

Other:

| Mapping                           | Function                          |
|:----------------------------------|:----------------------------------|
| `Ctrl-V` / `Ctrl-C`               | Regular copy and paste            |
| `Shift-PageUp` / `Shift-PageDown` | Scroll line by line               |
| `Ctrl-PageUp` / `Ctrl-PageDown`   | Scroll quickly                    |
| `Alt-p`                           | Open command [p]alette            |
| `Alt-d`                           | Open [d]ebug tab                  |
| `Alt-L`                           | Clear scrollback (like `Ctrl-l`)  |
| `Alt-R`                           | [R]eload config                   |
| `Alt-P`                           | Open [P]ython interactive console |
| `Ctrl-+-0`                        | Resize font                       |

