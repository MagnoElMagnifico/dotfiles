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
  vim.keymap.set(mode, mapping, mapped, { desc = desc, silent = true })
end

-- Leader key
vim.g.mapleader = ' '

---- Convenience changes ----
map({'n', 'v'}, '<Space>', '<Nop>')
map('n', 'U', '<C-R>', 'Redo')
map({'n', 'v', 'o'}, ',', ';', 'Repeat f, F, t, T')
map({'n', 'v', 'o'}, '_', ',', 'Repeat f, F, t, T backwards')

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
map('n', '<Leader>s', vim.cmd.write, 'Write current buffer')

---- Windows & Bufers & Tabs ----
-- Generic window command
map({'n', 'v'}, '<Space>w', '<C-w>', 'Window command')

-- Jump windows
map({'n', 'v'}, '<C-h>', '<C-w>h', 'Jump one window left')
map({'n', 'v'}, '<C-l>', '<C-w>l', 'Jump one window right')
map({'n', 'v'}, '<C-j>', '<C-w>j', 'Jump one window down')
map({'n', 'v'}, '<C-k>', '<C-w>k', 'Jump one window up')
map({'n', 'v'}, '<C-.>', '<C-w>p', 'Jump to the last accessed window')

-- Resize windows
local resize = 35
-- TODO: this can be better
-- map({'n', 'v'}, 'ñ<', resize .. '<C-w><', 'Decrease window width')
-- map({'n', 'v'}, ';<', resize .. '<C-w><', 'Decrease window width')
-- map({'n', 'v'}, 'ñ>', resize .. '<C-w>>', 'Increase window width')
-- map({'n', 'v'}, ';>', resize .. '<C-w>>', 'Increase window width')
--
-- map({'n', 'v'}, 'ñ+', resize .. '<C-w>+', 'Increase window height')
-- map({'n', 'v'}, ';+', resize .. '<C-w>+', 'Increase window height')
-- map({'n', 'v'}, 'ñ-', resize .. '<C-w>-', 'Decrease window height')
-- map({'n', 'v'}, ';-', resize .. '<C-w>-', 'Decrease window height')

-- Buffers
-- TODO: this can be better
map({'n', 'v'}, '<C-Right>', vim.cmd.bnext,     'Next buffer')
map({'n', 'v'}, '<C-Left>',  vim.cmd.bprevious, 'Previous buffer')
map({'n', 'v'}, 'go', '<C-^>', 'Alternate file')

---- Keep jumplist clean ----
local function nojumplist(mapping)
  -- TODO: For some reason, `<C-...>` won't work.
  return '<cmd>execute "keepjumps normal! '.. mapping .. '"<Enter>'
end

-- map({'n', 'v'}, '{', nojumplist('{'), 'Jump to previous empty line')
-- map({'n', 'v'}, '}', nojumplist('}'), 'Jump to next empty line')
-- map({'n', 'v'}, '(', nojumplist('('), 'Jump to previous sentence')
-- map({'n', 'v'}, ')', nojumplist(')'), 'Jump to next sentence')
--
-- map({'n', 'v'}, 'H', nojumplist('H'), 'Jump to the top of the screen')
-- map({'n', 'v'}, 'M', nojumplist('M'), 'Jump to middle of the screen')
-- map({'n', 'v'}, 'L', nojumplist('L'), 'Jump to bottom of the screen')
--
-- ---- Scroll ----
-- -- Make the bottom line be the centered one
-- map({'n', 'v'}, '<C-d>', nojumplist('M') .. '<C-d>zz', 'Scroll down half a screen')
-- -- Make the top line be the centered one
-- map({'n', 'v'}, '<C-u>', nojumplist('M') .. '<C-u>zz', 'Scroll up half a screen')
--
-- -- Make the bottom line the top one
-- map({'n', 'v'}, '<C-f>', '<C-f><C-e>' .. nojumplist('M'), 'Scroll down a screen')
-- -- Make the top line the bottom one
-- map({'n', 'v'}, '<C-b>', '<C-b><C-y>' .. nojumplist('M'), 'Scroll down a screen')

---- Centering cursor ----
map({'n', 'v'}, 'n', 'nzz', 'Next search match')
map({'n', 'v'}, 'N', 'Nzz', 'Previous search match')

---- Exiting ----
map('i', 'jk',    '<Esc>',       'Exit insert mode') -- Exit insert mode
map('i', 'kj',    '<Esc>',       'Exit insert mode')
map('t', '<Esc>', '<C-\\><C-n>', 'Exit terminal')    -- Exit terminal
map('t', 'jk',    '<C-\\><C-n>', 'Exit terminal')
map('t', 'kj',    '<C-\\><C-n>', 'Exit terminal')

