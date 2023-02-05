local map = vim.keymap.set
local tl = require('telescope.builtin')

-- More info:
-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim#pickers

-- Files
map('n', '<Leader>g', tl.git_files)                  -- Git files
map('n', '<Leader>a', tl.find_files)                 -- All files
map('n', '<Leader>ss', tl.live_grep)                 -- Search files
map('n', '<Leader>sw', tl.grep_string)               -- Search current word
map('n', '<Leader>/', tl.current_buffer_fuzzy_find)  -- Search in buffer

-- Vim
map('n', '<Leader>r', vim.cmd.reg)      -- Registers TODO: Telescope not working
map('n', '<Leader>b', tl.buffers)       -- Buffers
map('n', '<Leader>m', tl.marks)         -- Marks

map('n', '<Leader>tt', tl.builtin)       -- Telescope Pickers
map('n', '<Leader>to', tl.oldfiles)      -- Telescope Old files
map('n', '<Leader>ts', tl.spell_suggest) -- Telescope Spell check under cursor
map('n', '<Leader>tm', tl.man_pages)     -- Telescope Man pages
map('n', '<Leader>th', tl.help_tags)     -- Telescope Help

-- Git
map('n', '<Leader>tgs', tl.git_status)   -- Telescope Git Status
map('n', '<Leader>tgc', tl.git_bcommits) -- Telescope Git Commits
map('n', '<Leader>tgb', tl.git_branches) -- Telescope Git Branches

-- NOTE: Telescope's LSP config is in lsp.lua
