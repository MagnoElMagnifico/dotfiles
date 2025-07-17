return {
  -----------------------------------------------------------------------------
  ---- TELESCOPE --------------------------------------------------------------
  -----------------------------------------------------------------------------
  -- Telescope is a fuzzy finder whichs allows to quickly select one option in
  -- a list. This can be used to pick a file to jump to, neovim buffers, etc.
  --
  -- ---- PICKERS (':h telescope.builtin') ----
  -- Operations implemented by Telescope. They include a UI, a finder (generates
  -- results to pick), a prompt (user input that triggers the finder) and
  -- a previewer (preview of context of the selected entry)
  --
  -- 'telescope.builtin' contains a collection of pickers implemented as lua
  -- functions. For a complete list, check its manual.
  --
  --    FILE PICKERS: find_files, git_files, grep_string, live_grep
  --    VIM PICKERS: buffers, oldfiles, commands, quickfix, marks, ...
  --    LSP: lsp_references, lsp_incoming_calls, lsp_outcoming_calls
  --    GIT: git_commits, git_branches, git_status, git_stash
  --    OTHERS: treesitter, builtin
  --
  -- Use '<C-/>' in insert mode and '?' in normal mode to show the keymappings
  -- for the current picker.
  --
  -- ---- THEMES (':h telescope.themes') ----
  -- Common configurations grouped for convenience. 
  --
  --    - Dropdown
  --    - Cursor
  --    - Ivy
  --
  -- ---- LAYOUTS (':h telescope.layout') ----
  -- Positions of the prompt, list of results and previewer UIs.
  --
  --    - horizontal
  --    - vertical
  --    - flex
  --    - center
  --    - cursor
  --
  -- ---- COMMAND (':h telescope.command') ----
  -- The command ':Telescope' can be used to execute all the pickers with all
  -- the configurations:
  --
  --    :Telescope find_files hidden=true cwd=/some/dir
  --    :Telescope buffers theme=dropdown
  --
  -- With the limitation of not having any spaces in the options, as they are
  -- converted into the lua calls.
  --
  -- ---- MORE CONFIG ----
  -- Sorters and Previewers.
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',

    dependencies = {
      'nvim-lua/plenary.nvim', -- Required

      -- Improve performance with the native fzf program
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1 and vim.fn.executable 'fzf' == 1
        end,
      },
    },

    config = function()
      -- Here, we can configure each picker. Defaults are fine.
      -- See ':h telescope.setup()'
      require('telescope').setup {}

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')

      ---- MAPPINGS -----------------------------------------------------------
      -- See ':h telescope.builtin'
      local nmap = function(mapping, mapped, desc)
        vim.keymap.set('n', mapping, mapped, { desc = desc })
      end

      local builtin = require 'telescope.builtin'
      local themes  = require 'telescope.themes'
      nmap('<leader>f', builtin.find_files, 'Search Files')
      nmap('<leader>g', builtin.live_grep,  'Search by Grep')
      nmap('<leader>b', builtin.buffers,    'Search Buffers')

      nmap('<leader>tt', builtin.builtin,  'Search Select Telescope')
      nmap('<leader>t.', builtin.resume,   'Search Repeat (".")')
      nmap('<leader>to', builtin.oldfiles, 'Search Recent Files')

      nmap('<leader>tg', builtin.git_files,   'Search Git files')
      nmap('<leader>tw', builtin.grep_string, 'Search current Word')

      -- Vim
      nmap('<leader>td', builtin.diagnostics, 'Search Diagnostics')
      nmap('<leader>th', builtin.help_tags,   'Search Help')
      nmap('<leader>tk', builtin.keymaps,     'Search Keymaps')
      nmap('<leader>tm', builtin.marks,       'Search Marks')
      nmap('<leader>tr', builtin.registers,   'Search Registers')

      ---- CUSTOM -------------------------------------------------------------
      nmap('<leader>/', function()
        builtin.current_buffer_fuzzy_find(themes.get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, 'Fuzzily search in current buffer')

      nmap('<leader>t/', function()
        builtin.live_grep(themes.get_dropdown {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        })
      end, 'Search / in Open Files') -- TODO: delete maybe?

      -- Shortcut for searching Neovim configuration files
      nmap('<leader>tc', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, 'Search Config files')
    end,

  } -- telescope
} -- return
