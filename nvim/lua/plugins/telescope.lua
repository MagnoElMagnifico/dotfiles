return {
  {
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',

      {
        -- If encountering errors, see telescope-fzf-native README for
        -- installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },

      'nvim-telescope/telescope-ui-select.nvim',

      -- Useful for getting pretty icons, but requires a Nerd Font
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }
    },

    config = function()

      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local nmap = function (mapping, mapped, desc) vim.keymap.set('n', mapping, mapped, { desc = desc }) end

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      nmap('<leader>f', builtin.find_files, 'Search Files')
      nmap('<leader>g', builtin.live_grep,  'Search by Grep')

      nmap('<leader>st', builtin.builtin,  'Search Select Telescope')
      nmap('<leader>s.', builtin.resume,   'Search Repeat (".")')
      nmap('<leader>so', builtin.oldfiles, 'Search Recent Files')

      nmap('<leader>sg', builtin.git_files,   'Search Git files')
      nmap('<leader>sw', builtin.grep_string, 'Search current Word')

      -- Vim
      nmap('<leader>sb', builtin.buffers,     'Search Buffers')
      nmap('<leader>sd', builtin.diagnostics, 'Search Diagnostics')
      nmap('<leader>sh', builtin.help_tags,   'Search Help')
      nmap('<leader>sk', builtin.keymaps,     'Search Keymaps')
      nmap('<leader>sm', builtin.marks,       'Search Marks')
      nmap('<leader>sr', builtin.registers,   'Search Registers')

      nmap('<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, '/ Fuzzily search in current buffer')

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      nmap('<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, 'Search / in Open Files')

      -- Shortcut for searching your Neovim configuration files
      nmap('<leader>sc', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, 'Search Config files')
    end,

  }
} -- return
