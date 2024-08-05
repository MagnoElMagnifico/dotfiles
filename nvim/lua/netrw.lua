-- More info :h netrw-quickmap and :NetrwSettings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20

-- Sort directories first
vim.g.netrw_sort_sequence = '[\\/]$'

-- More mappings :h netrw-quickhelp
local map = vim.keymap.set
map('n', '<Leader>ee', vim.cmd.Explore,  { desc = 'Launch Explorer' })
map('n', '<Leader>ec', function() vim.cmd('Explore ' .. vim.fn.getcwd()) end,  { desc = 'Launch Explorer in CWD' })
map('n', '<Leader>ev', vim.cmd.Lexplore, { desc = 'Toggle Explorer in new Vertical split' })
map('n', '<Leader>et', vim.cmd.Texplore, { desc = 'Launch Explorer in new Tab' })


--[[

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

]]
