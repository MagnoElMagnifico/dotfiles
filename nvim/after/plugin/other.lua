local map = vim.keymap.set

---- Netrw ----
-- More info :h netrw-quickmap and :NetrwSettings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20

-- More mappings :h netrw-quickhelp
map('n', '<Leader>ee', vim.cmd.Ex,  { desc = 'Launch [E]xplorer' })
map('n', '<Leader>et', vim.cmd.Tex, { desc = 'Launch [E]xplorer in new [T]ab' })
map('n', '<Leader>ev', vim.cmd.Lex, { desc = 'Launch [E]xplorer in new [V]ertical split' })


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

---- Comment.nvim ----
require('Comment').setup()

---- Indent Blankline ----
-- See `:help indent_blankline.txt`
require('indent_blankline').setup {
  char = '┊',
  show_trailing_blankline_indent = false,
}

---- Vim Easy Align ----
map({'n', 'v'}, 'gA', 'ga')
map({'n', 'v'}, 'ga', '<Plug>(EasyAlign)') -- Go Align

