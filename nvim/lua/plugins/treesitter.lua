return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

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

      highlight = {
        enable = true,
        -- -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        -- --  If you are experiencing weird indenting issues, add the language to
        -- --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        -- additional_vim_regex_highlighting = { 'python' },
      },

      indent = { enable = true, disable = { 'python' } },
    },

    config = function(_, opts)
      -- See `:help nvim-treesitter`
      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  }, -- treesitter
} -- return

-- incremental_selection = {
--   enable = true,
--   keymaps = {
--     init_selection = '<c-space>',
--     node_incremental = '<c-space>',
--     scope_incremental = '<c-s>',
--     node_decremental = '<c-backspace>',
--   },
-- },
--
-- textobjects = {
--   select = {
--     enable = true,
--     lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--     keymaps = {
--       -- You can use the capture groups defined in textobjects.scm
--       ['aa'] = '@parameter.outer', -- TODO: ???
--       ['ia'] = '@parameter.inner', -- TODO: ???
--       ['af'] = '@function.outer',
--       ['if'] = '@function.inner',
--       ['ac'] = '@class.outer',
--       ['ic'] = '@class.inner',
--     },
--   },
--
--   move = {
--     enable = true,
--     set_jumps = true, -- whether to set jumps in the jumplist
--     goto_next_start = {
--       [']m'] = '@function.outer',
--       [']]'] = '@class.outer',
--     },
--     goto_next_end = {
--       [']M'] = '@function.outer',
--       [']['] = '@class.outer',
--     },
--     goto_previous_start = {
--       ['[m'] = '@function.outer',
--       ['[['] = '@class.outer',
--     },
--     goto_previous_end = {
--       ['[M'] = '@function.outer',
--       ['[]'] = '@class.outer',
--     },
--   },
--   swap = {
--     enable = true,
--     -- TODO: ???
--     swap_next = {
--       ['<leader>-'] = '@parameter.inner',
--     },
--     swap_previous = {
--       ['<leader>_'] = '@parameter.inner',
--     },
--   },
-- },
