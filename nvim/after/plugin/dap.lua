-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- https://github.com/nvim-lua/wishlist/issues/37
-- https://github.com/puremourning/vimspector

-- Maybe even better than DAP:
vim.cmd.packadd('termdebug')
vim.g.termdebug_wide = 80

local map = vim.keymap.set

map('n', '<Leader>db', vim.cmd.Break)    -- Add breakpoint
map('n', '<Leader>dB', vim.cmd.Clear)    -- Remove breakpoint
map('n', '<Leader>n',  vim.cmd.Step)     -- Advance to next line
map('n', '<Leader>o',  vim.cmd.Over)     -- Advance to the next line without entering functions
map('n', '<Leader>du', vim.cmd.Until)    -- Run until cursor
map('n', '<Leader>dc', vim.cmd.Continue) -- Continue until next breakpoint
map('n', '<Leader>df', vim.cmd.Finish)   -- Continue until the end of the function

