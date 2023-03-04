-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- https://github.com/nvim-lua/wishlist/issues/37

-- Maybe even better than DAP:
vim.cmd.packadd('termdebug')
vim.g.termdebug_wide = 80

local map = vim.keymap.set

map('n', '<Leader>db', vim.cmd.Break)  -- Add breakpoint
map('n', '<Leader>dB', vim.cmd.Clear)  -- Remove breakpoint
map('n', '<Leader>ds', vim.cmd.Step)
map('n', '<Leader>do', vim.cmd.Over)
-- map('n', '<Leader>du', vim.cmd.Until)
-- map('n', '<Leader>df', vim.cmd.Finish)
-- map('n', '<Leader>dc', vim.cmd.Continue)
-- map('n', '<Leader>dp', vim.cmd.Stop)
