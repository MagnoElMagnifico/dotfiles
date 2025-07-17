require 'options'
require 'keymaps'
-- require 'commands'
require 'autocommands'
require 'netrw'

-- TODO: https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua

---- LAZY PACKAGE MANAGER ----
-- This plugin allows to manage other plugins automatically.
--
--    :Lazy         Open lazy.nvim menu to check your plugins' status
--                  You can use '?' in this menu for help.
--                  ':q' closes the window.
--    :Lazy check   Check for updates (git fetch)
--    :Lazy update  Updates all the installed plugins (updates lockfile)
--    :Lazy clean   Delete plugins no longer needed
--    :Lazy restore Goes back to the version of the lockfile
--
-- Plugins are installed in the following directories, so to remove lazy.nvim,
-- you can just delete them.
--
--    data      ~/.local/share/nvim/lazy/
--    state     ~/.local/state/nvim/lazy/
--    lockfile  ~/.config/nvim/lazy-lock.json
--
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

-- Now, specify which plugins to download
require('lazy').setup({
  -- Plugins with its own configuration
  require 'plugins.treesitter', -- Better syntax highlighting
  require 'plugins.telescope',  -- Fuzzy find files and grep

  -- TODO:
  require 'plugins.lsp',        -- Language Servers
  require 'plugins.cmp',        -- Autocompletion
  require 'plugins.git',        -- Git integration
  require 'plugins.format',     -- Formatting code
  -- require 'plugins.debug',      -- Debugger support
  -- require 'plugins.whichkey',   -- Help with keybinds
  require 'plugins.looks',      -- Visuals, colorschemes and status line
  -- require 'plugins.oil',        -- File manager

  ---- Utilities ----
  -- Other plugins to make a better experience
  'tpope/vim-sleuth',  -- Detect tabstop and shiftwidth automatically

  -- Not a recurrent problem, but might be interesting to have:
  -- https://github.com/LunarVim/bigfile.nvim

  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 } -- Expansion of a/i text-objects
      require('mini.surround').setup()           -- Surround actions
      require('mini.align').setup()              -- Align text interactively
      require('mini.icons').setup()              -- Icon provider
      require('mini.files').setup()

      vim.keymap.set({'n', 'v', 'x'}, '<leader>-', function()
        MiniFiles.open(vim.api.nvim_buf_get_name(0))
      end, { desc = 'Open file explorer in parent directory', silent = true })

      vim.keymap.set({'n', 'v', 'x'}, '<leader>_', function()
        MiniFiles.open(nil, false)
      end, { desc = 'Open file explorer in current working directory', silent = true })

      -- Interesting to checkout:
      --     - bracketed:  https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
      --     - jump:       https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-jump.md
      --     - statusline  lualine
      --     - miniclue
      --     - operators
    end
  },

  -- NOTE: using nvim's functionality for now (:h commenting), but it's missing:
  --    - Block comments: gb
  --    - Comments on newlines: gco gcO
  -- { 'numToStr/Comment.nvim', opts = {} }, -- Toggle comments with 'gcc' and 'gbc'
})
