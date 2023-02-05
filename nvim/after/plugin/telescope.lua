local map = vim.keymap.set
local tl = require('telescope.builtin')

-- More info:
-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim#pickers

-- Files
map('n', '<Leader>g', tl.git_files)      -- Git files
map('n', '<Leader>a', tl.find_files)     -- All files
map('n', '<Leader>s', tl.live_grep)      -- Search files
map('n', '<leader>sw', tl.grep_string)   -- Search current word

-- Vim
map('n', '<Leader>r', vim.cmd.reg)      -- Registers TODO: Telescope not working
map('n', '<Leader>b', tl.buffers)       -- Buffers
map('n', '<Leader>m', tl.marks)         -- Marks

map('n', '<Leader>tt', tl.builtin)       -- Telescope Pickers
map('n', '<Leader>to', tl.oldfiles)      -- Telescope Old files
map('n', '<Leader>ts', tl.spell_suggest) -- Telescope Spell check under cursor
map('n', '<Leader>tm', tl.man_pages)     -- Telescope Man pages
map('n', '<Leader>th', tl.help_tags)     -- Telescope Help

-- LSP
-- TODO: Telescope LSP
-- lsp_references                  Lists LSP references for word under the cursor
-- lsp_incoming_calls              Lists LSP incoming calls for word under the cursor
-- lsp_outgoing_calls              Lists LSP outgoing calls for word under the cursor
-- lsp_document_symbols            Lists LSP document symbols in the current buffer
-- lsp_workspace_symbols           Lists LSP document symbols in the current workspace
-- lsp_dynamic_workspace_symbols   Dynamically Lists LSP for all workspace symbols
-- diagnostics                     Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
-- lsp_implementations             Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
-- lsp_definitions                 Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
-- lsp_type_definitions            Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope
map('n', '<Leader>lr', tl.lsp_references)
map('n', '<Leader>ls', tl.lsp_document_symbols)
map('n', '<leader>sd', tl.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>/', tl.current_buffer_fuzzy_find, { desc = '[S]earch [D]iagnostics' })

-- Git
map('n', '<Leader>tgs', tl.git_status)   -- Telescope Git Status
map('n', '<Leader>tgc', tl.git_bcommits) -- Telescope Git Commits
map('n', '<Leader>tgb', tl.git_branches) -- Telescope Git Branches

