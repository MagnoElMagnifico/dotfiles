-----------------------------------------------------------
---- Options ----------------------------------------------
-----------------------------------------------------------
-- Use Python inside Neovim
--     IMPORTANT: Remember to:
--     `python3 -m pip install pynvim`
--     `sudo apt install python3-pynvim`
-- vim.g.python3_host_prog = '/usr/bin/python3'

-- Tabs and trailing spaces (:h 'list' and :h 'listchars')
vim.o.list = true
vim.opt.listchars = {
  tab = '> ',
  trail = '·',
  nbsp = '␣',
}

-- Visual
vim.o.termguicolors  = true
vim.o.showmode       = false -- Don't show the mode, since it's already in the status line
vim.o.showmatch      = true  -- Show matching brackets
vim.o.cmdheight      = 1
vim.o.lazyredraw     = true  -- Don't update while executing macros
vim.o.synmaxcol      = 300   -- Maximum columns to search for syntax
vim.o.conceallevel   = 0     -- TODO: ?
vim.o.concealcursor  = ''    -- TODO: ?
vim.o.signcolumn     = 'yes'

-- Completion
vim.opt.path:append('**')
vim.o.mouse = 'a'
vim.o.pumheight   = 10    -- Maximum elements on completion window
vim.o.completeopt = 'menuone,noselect'

-- Behaviour
vim.o.selection = 'inclusive'
vim.o.hidden = true -- TODO: Hidden buffers?
vim.o.errorbells = false
vim.o.backspace = 'indent,eol,start,nostop'
vim.o.autochdir = false  -- Don't autochange directories
vim.opt.iskeyword:append('-') -- TODO: Treat '-' as part of a word

-- Fonts
vim.g.have_nerd_font = true

-- Timings
vim.o.timeoutlen = 750
vim.o.updatetime = 250

-- File
vim.o.fileencoding = 'utf-8'
vim.o.spelllang    = 'es,en'
vim.o.undofile     = true
vim.o.backup       = false
vim.o.writebackup  = false
vim.o.autoread     = true
vim.o.autowrite    = false

-- Format
vim.o.autoindent    = true
vim.o.textwidth     = 80
vim.o.colorcolumn   = '80'
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
vim.o.hlsearch = true

-- Window opening
vim.o.splitbelow = true
vim.o.splitright = true

