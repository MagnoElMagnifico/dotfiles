---- Colorshemes: https://vimcolorschemes.com/ ----
return {
  -- Default colorsheme
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'onedark'
    end,
    opts = {
      style = 'darker'  -- dark, darker, cool, deep, warm, warmer, light
    }
  },

   -- :colorscheme drakula, drakula-soft
  { 'Mofiqul/dracula.nvim', lazy = true },

  -- :colorscheme sonokai
  -- :let g:sonokai_style = default, atlantis, andromeda, shusia, maia, espresso
  { 'sainnhe/sonokai', lazy = true },

  -- :colorscheme tokyonight
  -- :colorscheme tokyonight-night
  -- :colorscheme tokyonight-storm
  -- :colorscheme tokyonight-day
  -- :colorscheme tokyonight-moon
  { 'folke/tokyonight.nvim', lazy = true },

  -- Identation lines
  {
    'lukas-reineke/indent-blankline.nvim',

    lazy = true,
    event = 'BufEnter',

    main = 'ibl',
    opts = {},
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',

    lazy = true,
    event = 'BufEnter',

    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false }
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',

    lazy = true,
    event = 'VimEnter',

    opts = {
      -- See `:help lualine.txt`
      options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = '|',
        section_separators = '',
      },

      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      },
    }
  }
}
