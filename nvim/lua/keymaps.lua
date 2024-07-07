-----------------------------------------------------------
---- Remaps -----------------------------------------------
-----------------------------------------------------------
-- Modes
--   n    Normal
--   i    Insert
--   c    Command
--   v    Visual and Select
--   x    Visual
--   s    Select
--   t    Terminal (insert mode inside of a terminal)
local map = function(mode, mapping, mapped, desc)
  vim.keymap.set(mode, mapping, mapped, { desc = desc })
end
vim.g.mapleader = ' '

---- Convenience changes ----
map({'n', 'v'}, '<Space>', '<Nop>')
map('n', 'U', '<C-R>', 'Redo')
map({'n', 'v'}, "'", '`')
map('i', '<C-H>', '<C-w>', 'Delete word in insert mode')

-- Moving faster in the line
map({'n', 'v', 'o'}, '+', '$', 'Go to end of line')
map({'n', 'v', 'o'}, '-', '^', 'Go to start of line')

-- NOTE: I use a EU keyboard, not US.
map({'n', 'v', 'o'}, ';', ',')     -- Repeat f, F, t, T backwards
map({'n', 'v', 'o'}, ',', ';')     -- Repeat f, F, t, T

-- Stay in visual mode after identing
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Yank and Paste
map({'n', 'v'}, '<Leader>y', '"+y',  '[Y]ank to system clipboard')
map({'n', 'v'}, '<Leader>p', '"+p',  '[P]aste from system clipboard')
map('n',        '<Leader>Y', '"+Y',  '[Y]ank to system clipboard')
map('n',        '<Leader>P', '"+P',  '[P]aste from system clipboard')

---- Commands ----
map('n', '<Leader>x', vim.cmd.bdel,  'Delete current buffer')
map('n', '<Leader>w', vim.cmd.write, '[W]rite current buffer')

---- Centering cursor ----
map({'n', 'v'}, 'n', 'nzz')
map({'n', 'v'}, 'N', 'Nzz')

map({'n', 'v'}, '<C-b>', '<C-b>zz')
map({'n', 'v'}, '<C-f>', '<C-f>zz')
map({'n', 'v'}, '<C-d>', '<C-d>zz')
map({'n', 'v'}, '<C-u>', '<C-u>zz')

---- Windows & Buffers & Tabs ----
map({'n', 'v'}, 'ñ', '<C-w>', 'Window command')
map({'n', 'v'}, 'Ñ', '<C-w>', 'Window command')
map({'n', 'v'}, '<C-Right>', vim.cmd.bnext,     'Next buffer')
map({'n', 'v'}, '<C-Left>',  vim.cmd.bprevious, 'Previous buffer')

-- Scroll
map({'n', 'v'}, '<C-k>', '<C-y>', 'Scroll up')
map({'n', 'v'}, '<C-j>', '<C-e>', 'Scroll down')

---- Exiting ----
map('t', '<Esc>', '<C-\\><C-n>', 'Exit terminal')    -- Exit terminal
map('t', 'jk',    '<C-\\><C-n>', 'Exit terminal')
map('t', 'kj',    '<C-\\><C-n>', 'Exit terminal')
map('i', 'jk',    '<Esc>',       'Exit insert mode') -- Exit insert mode
map('i', 'kj',    '<Esc>',       'Exit insert mode')

---- Terminal moving ----
map('t', '<C-w>j', '<C-\\><C-n><C-w>j')
map('t', '<C-w>k', '<C-\\><C-n><C-w>k')
map('t', '<C-w>h', '<C-\\><C-n><C-w>h')
map('t', '<C-w>l', '<C-\\><C-n><C-w>l')

