local map = vim.keymap.set

---- Netrw ----
-- More info :h netrw-quickmap and :NetrwSettings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20

-- More mappings :h netrw-quickhelp
map('n', '<Leader>ee', vim.cmd.Ex)       -- Explorer
map('n', '<Leader>et', vim.cmd.Tex)      -- Explorer in new Tab
map('n', '<Leader>ev', vim.cmd.Lex)      -- Explorer left (vertical)


---- LuaLine ----
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}

---- Gitsigns ----
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- Enable Comment.nvim
require('Comment').setup()

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

