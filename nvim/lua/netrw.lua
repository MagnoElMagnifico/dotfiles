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

