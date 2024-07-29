require 'autocommands'
require 'options'
require 'keymaps'
require 'netrw'

-- Bootstrap lazy.nvim package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    'https://github.com/folke/lazy.nvim.git',
    lazypath
  }

  if vim.v.shell_error ~= 0 then
    -- Show the error it the previous command was not successful
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim\nError message' },
      { out, 'Warning message' },
      { '\nPress any key to exit...' },
    }, true, {})

    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)


--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
require('lazy').setup({
  require 'plugins.looks',
  require 'plugins.telescope',
  require 'plugins.treesitter',
  require 'plugins.lsp',
  require 'plugins.cmp',
  require 'plugins.git',
  require 'plugins.format',
  require 'plugins.debug',
  require 'plugins.which-key',

  ---- Utilities ----
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      require('mini.align').setup()
    end
  },

  { 'numToStr/Comment.nvim', opts = {} }, -- Toggle comments with 'gcc' and 'gbc'
  'tpope/vim-sleuth',                     -- Detect tabstop and shiftwidth automatically
})
