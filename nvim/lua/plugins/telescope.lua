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
      nmap('<leader>f', builtin.find_files, 'Search [F]iles')
      nmap('<leader>g', builtin.live_grep,  'Search by [G]rep')

      nmap('<leader>st', builtin.builtin,  '[S]earch Select [T]elescope')
      nmap('<leader>s.', builtin.resume,   '[S]earch Repeat (".")')
      nmap('<leader>so', builtin.oldfiles, '[S]earch [R]ecent Files')

      nmap('<leader>sg', builtin.git_files,   '[S]earch [G]it files')
      nmap('<leader>sw', builtin.grep_string, '[S]earch current [W]ord')

      -- Vim
      nmap('<leader>sb', builtin.buffers,     '[S]earch [B]uffers')
      nmap('<leader>sd', builtin.diagnostics, '[S]earch [D]iagnostics')
      nmap('<leader>sh', builtin.help_tags,   '[S]earch [H]elp')
      nmap('<leader>sk', builtin.keymaps,     '[S]earch [K]eymaps')
      nmap('<leader>sm', builtin.marks,       '[S]earch [M]arks')
      nmap('<leader>sr', builtin.registers,   '[S]earch [R]egisters')

      nmap('<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, '[/] Fuzzily search in current buffer')

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      nmap('<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, '[S]earch [/] in Open Files')

      -- Shortcut for searching your Neovim configuration files
      nmap('<leader>sc', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, '[S]earch [C]onfig files')
    end,

  }
} -- return
