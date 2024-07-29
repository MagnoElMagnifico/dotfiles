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
map('i', '<C-H>', '<C-w>', 'Delete word in insert mode')

-- Moving faster in the line
map({'n', 'v', 'o'}, '+', '$', 'Go to end of line')
map({'n', 'v', 'o'}, '-', '^', 'Go to start of line')
map({'n', 'v', 'o'}, '&', '^', 'Go to start of line')

map({'n', 'v', 'o'}, ',', ';', 'Repeat f, F, t, T')
-- map({'n', 'v', 'o'}, ';', ',', 'Repeat f, F, t, T backwards')

-- Stay in visual mode after identing
map('v', '<', '<gv', 'Unintend selection')
map('v', '>', '>gv', 'Indent selection')

-- Yank and Paste
map({'n', 'v'}, '<Leader>y', '"+y',  'Yank to system clipboard')
map({'n', 'v'}, '<Leader>p', '"+p',  'Paste from system clipboard')
map('n',        '<Leader>Y', '"+Y',  'Yank to system clipboard')
map('n',        '<Leader>P', '"+P',  'Paste from system clipboard')

---- Commands ----
map('n', '<Leader>x', vim.cmd.bdel,  'Delete current buffer')
map('n', '<Leader>w', vim.cmd.write, 'Write current buffer')

---- Centering cursor ----
map({'n', 'v'}, 'n', 'nzz', 'Next search match')
map({'n', 'v'}, 'N', 'Nzz', 'Previous search match')

map({'n', 'v'}, '<C-b>', '<C-b>zz', 'Scroll down half a window')
map({'n', 'v'}, '<C-f>', '<C-f>zz', 'Scroll up half a window')
map({'n', 'v'}, '<C-d>', '<C-d>zz', 'Scroll down a window')
map({'n', 'v'}, '<C-u>', '<C-u>zz', 'Scroll up a window')

---- Windows & Buffers & Tabs ----
map({'n', 'v'}, 'ñ', '<C-w>', 'Window command')
map({'n', 'v'}, 'Ñ', '<C-w>', 'Window command')
map({'n', 'v'}, ';', '<C-w>', 'Window command')  -- NOTE: experimental
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

