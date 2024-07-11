-- More info :h netrw-quickmap and :NetrwSettings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20

-- Sort directories first
vim.g.netrw_sort_sequence = '[\\/]$'

-- More mappings :h netrw-quickhelp
local map = vim.keymap.set
map('n', '<Leader>ee', vim.cmd.Ex,  { desc = 'Launch [E]xplorer' })
map('n', '<Leader>et', vim.cmd.Tex, { desc = 'Launch [E]xplorer in new [T]ab' })
map('n', '<Leader>ev', vim.cmd.Lex, { desc = 'Launch [E]xplorer in new [V]ertical split' })

