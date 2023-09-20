-- OneDark
local onedark = require('onedark')
onedark.setup { style = 'warmer' }  -- dark, darker, cool, deep, warm, warmer, light
onedark.load()

-- Sonokai: default, atlantis, andromeda, shusia, maia, espresso
vim.api.nvim_set_var('sonokai_style', 'andromeda')

---- LuaLine ----
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
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

