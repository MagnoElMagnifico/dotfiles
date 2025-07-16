return {
  -- Tree-sitter is a parsing library that generates a tree of some source code.
  -- As a result, Neovim has more information about the code since it
  -- understands how it is structured, so it can provide additional
  -- functionalities. These are provided by this package as different modules:
  -- highlight, incremental_selection, indent (see details below).
  --
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter, but as separate plugins:
  --
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects:  https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  --
  -- The plugin also includes some functions:
  --
  --    - :h nvim-treesitter-utils
  --    - :h nvim-treesitter-functions
  --
  -- COMMANDS
  --    :TSInstall {lang}   Install a new parser
  --    :TSInstallInfo      List of supported languages
  --    :TSUpdate [lang]    Update a parser or all the installed ones
  --    :TSModuleInfo       Show the state of every module (highlight,
  --                        incremental_selection, indent) for every parser
  --    :TSToggle {mod}     Dis/enable modules for the current session
  --    :TSBufToggle {mod}  Dis/enable modules for the current buffer
  --
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,        -- Lazy loading is not supported
    build = ':TSUpdate', -- Must update parsers at the same time

    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'java',
        'lua',
        'luadoc',
        'markdown',
        'python',
        'rust',
        'vim',
        'vimdoc',
      },

      -- Autoinstall languages that are not installed
      auto_install = true,

      ---- MODULES ------------------------------------------------------------
      -- Consistent syntax highlighting functionalities, even with modifications
      -- or errors (as you're typing).
      highlight = {
        enable = true,

        -- Disable in files with more than 5K lines, which could slow down Neovim
        disable = function(_, bufnr)
          return vim.api.nvim_buf_line_count(bufnr) > 5000
        end,
      },

      -- Indentation based on tree-sitter for the '=' operator
      indent = {
        enable = true,
      },

      -- Incremental selection based on the named nodes from the grammar.
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection    = 'gnn',  -- Start incremental selection
          scope_incremental = 'grc',  -- Increment to upper scope
          node_incremental  = 'grn',  -- Increment selection to named parent
          node_decremental  = 'grm',  -- Decrement to previous named node
        },
      },
    },

    config = function(_, opts)
      -- Prefer git instead of curl in order to improve connectivity in some
      -- environments
      require('nvim-treesitter.install').prefer_git = true

      -- Now apply the configuration
      require('nvim-treesitter.configs').setup(opts)
    end,
  }, -- treesitter
} -- return
