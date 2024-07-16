-- More info :h netrw-quickmap and :NetrwSettings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20

-- Sort directories first
vim.g.netrw_sort_sequence = '[\\/]$'

-- More mappings :h netrw-quickhelp
local map = vim.keymap.set
map('n', '<Leader>ee', vim.cmd.Explore,  { desc = 'Launch [E]xplorer (opened file)' })
map('n', '<Leader>ec', function() vim.cmd('Explore ' .. vim.fn.getcwd()) end,  { desc = 'Launch [E]xplorer (PWD)' })
map('n', '<Leader>ev', vim.cmd.Lexplore, { desc = 'Toggle [E]xplorer in new [V]ertical split' })
map('n', '<Leader>et', vim.cmd.Texplore, { desc = 'Launch [E]xplorer in new [T]ab' })

