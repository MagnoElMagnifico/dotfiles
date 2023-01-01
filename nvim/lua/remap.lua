-- Modes
--   n    Normal
--   i    Insert
--   c    Command
--   v    Visual and Select
--   x    Visual
--   s    Select
--   t    Terminal (insert mode inside of a terminal)
local map = vim.keymap.set
vim.g.mapleader = ' '

---- Misc ----
map({'n', 'v'}, '+', '$')
map({'n', 'v'}, '-', '^')

map('i', '<C-H>', '<C-w>')    -- Delete word in Insert mode
map('n', 'U',     '<C-R>')    -- Redo with U

-- Stay in visual mode after identing
map('v', '<', '<gv')
map('v', '>', '>gv')

map({'n', 'x'}, "'", '`')

-- NOTE: I use a EU keyboard, not US.
map({'n', 'v'}, ';', ',')     -- Repeat f, F, t, T backwards
map({'n', 'v'}, ',', ';')     -- Repeat f, F, t, T

-- Yank and Paste
map('v', '<Leader>p', '"_dP')
map('n', '<Leader>Y', '"+Y')
map({'n', 'v'}, '<Leader>y', '"+y')   -- Yank to system clipboard
map({'n', 'v'}, '<Leader>d', '"_d')

---- Commands ----
-- Refactor symbol (Change)
map('n', '<Leader>c', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
map('n', '<Leader>x', vim.cmd.bdel)
map('n', '<Leader>w', vim.cmd.write)

-- TODO: Not working
-- Move text
--map('n', '<A-j>', function() vim.cmd.move('+1') end)
--map('n', '<A-k>', function() vim.cmd.move('-2') end)
--map('v', 'J', "<CMD>move '>+1<Enter>gv=gv")
--map('v', 'K', "<CMD>move '<-2<Enter>gv=gv")

-- Scroll
map({'n', 'v'}, '<C-k>', '<C-y>') -- Scroll
map({'n', 'v'}, '<C-j>', '<C-e>')

---- Centering cursor ----
map({'n', 'v'}, 'n', 'nzz')
map({'n', 'v'}, 'N', 'Nzz')

map({'n', 'v'}, '<C-b>', '<C-b>zz')
map({'n', 'v'}, '<C-f>', '<C-f>zz')
map({'n', 'v'}, '<C-d>', '<C-d>zz')
map({'n', 'v'}, '<C-u>', '<C-u>zz')

---- Windows & Buffers & Tabs ----
map({'n', 'v'}, 'ñ', '<C-w>')
map({'n', 'v'}, 'Ñ', '<C-w>')
map('n', '<C-Right>', vim.cmd.tabn) -- Move between tabs
map('n', '<C-Left>',  vim.cmd.tabp)

---- Exiting ----
map('t', '<Esc>', '<C-\\><C-N>')    -- Exit terminal
map('t', 'jk',    '<C-\\><C-N>')
map('t', 'kj',    '<C-\\><C-N>')
map({'i', 'v'}, 'jk',    '<Esc>')          -- Exit insert mode
map({'i', 'v'}, 'kj',    '<Esc>')
