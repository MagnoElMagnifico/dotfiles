return {
  ---- COLORSCHEMES -----------------------------------------------------------
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    -- dark, darker, cool, deep, warm, warmer, light
    opts = { style = 'darker' }
  },

   -- :colorscheme drakula, drakula-soft
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
  },

  -- :colorscheme sonokai
  {
    'sainnhe/sonokai',
    lazy = false,
    priority = 1000,
    config = function()
      -- default, atlantis, andromeda, shusia, maia, espresso
      vim.g.sonokai_style = 'atlantis'
      vim.g.sonokai_enable_italic = true
    end
  },

  -- :colorscheme tokyonight
  -- :colorscheme tokyonight-night
  -- :colorscheme tokyonight-storm
  -- :colorscheme tokyonight-day
  -- :colorscheme tokyonight-moon
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
  },

  ---- OTHER VISUAL EFECTS ----------------------------------------------------
  -- Render indentation lines
  {
    'lukas-reineke/indent-blankline.nvim',

    lazy = true,
    event = 'BufEnter',

    main = 'ibl',
    opts = {},
  },

  -- Highlight specific comments:
  --   FIX: FIXME, BUG, FIXIT, ISSUE
  --   TODO:
  --   HACK:
  --   WARN: WARNING, XXX
  --   PERF: OPTIM, PERFORMANCE, OPTIMIZE
  --   NOTE: INFO
  --   TEST: TESTING, PASSED, FAILED
  --
  -- Also adds the following commands to easily jump to them:
  --
  --  :TodoTelescope  Open in Telescope
  --  :TodoQuickFix   Open in a quickfix window
  --  :TodoLocFix     Open in a location list
  --
  -- With the arguments:
  --
  --  cwd       Directory where to search
  --  keywords  Comma-separated list of types (FIX, TODO, HACK...)
  --
  {
    'folke/todo-comments.nvim',

    lazy = true,
    event = 'BufEnter',

    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      highlight = { multiline = false },
    }
  },

} -- return
