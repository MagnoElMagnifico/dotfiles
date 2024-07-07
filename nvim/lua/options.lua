-----------------------------------------------------------
---- Options ----------------------------------------------
-----------------------------------------------------------
-- Misc
vim.opt.path:append('**')
vim.o.completeopt    = 'menuone,noselect'
vim.o.mouse          = 'a'
vim.o.termguicolors  = true
vim.o.undofile       = true
vim.o.showmode       = false -- Don't show the mode, since it's already in the status line
vim.o.clipboard      = 'unnamedplus'
vim.o.signcolumn     = 'yes'
vim.g.have_nerd_font = true

-- Timings
vim.o.timeoutlen = 300
vim.o.updatetime = 250

-- Use Python inside Neovim
--     IMPORTANT: Remember to:
--     `python3 -m pip install pynvim`
--     `sudo apt install python3-pynvim`
vim.g.python3_host_prog = '/usr/bin/python3'

-- File
vim.o.fileencoding = 'utf-8'
vim.o.spelllang    = 'es,en'

-- Tabs and trailing spaces (:h 'list' and :h 'listchars')
vim.o.list      = true
vim.o.listchars = 'tab:>>,trail:·'
-- TODO: this do not work
-- vim.o.listchars = {
--   tab = '>>',
--   trail = '·',
--   nbsp = '␣',
-- }

-- Format
vim.o.autoindent    = true
vim.o.textwidth     = 80
vim.o.formatoptions = 'tcro/qjnl1' -- :h fo-table

-- Indent
vim.o.autoindent  = true
vim.o.expandtab   = true
vim.o.smartindent = true
vim.o.tabstop     = 4
vim.o.shiftwidth  = 4

-- Wrap
vim.o.wrap        = false
vim.o.breakindent = true
vim.o.showbreak   = '\\'

-- Folds
vim.o.foldmethod     = 'indent'
vim.o.foldenable     = true
vim.o.foldlevelstart = 5
vim.o.foldnestmax    = 5

-- Scroll
vim.o.scrolloff     = 10
vim.o.sidescrolloff = 10

-- Line numbers
vim.o.relativenumber = true
vim.o.number         = true

-- Search
vim.o.smartcase  = true  -- Search case insensitive, unless the search term contains an upper case
vim.o.ignorecase = true
vim.o.incsearch  = true
vim.o.inccommand = 'nosplit'

-- Highlight on search, but clear on <Esc> in normal mode
vim.o.hlsearch = true -- No highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Window opening
vim.o.splitbelow = true
vim.o.splitright = true

