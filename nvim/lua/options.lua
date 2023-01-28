local o = vim.o

o.fileencoding = 'utf-8'
o.langmenu     = 'en_US.UTF8' -- Language
o.spell        = false
o.spelllang    = 'es,en'

-- Delete trailing whitespace
-- Mode info at :h 'list' and :h 'listchars'
o.list      = true
o.listchars = 'tab:>>,trail:·'

-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--     pattern = "*",
--     command = "%s/\\s\\+$//e",
-- })

vim.opt.path:append('**')
o.mouse = 'a'
o.termguicolors = true

o.timeoutlen = 500
o.cmdheight  = 1

-- Indent
o.autoindent  = true
o.expandtab   = true
o.smartindent = true
o.tabstop     = 4
o.shiftwidth  = 4

-- Wrap
o.wrap      = false
o.showbreak = '\\' -- Wrapped text

-- Scroll
o.scrolloff     = 4
o.sidescrolloff = 4

-- Line numbers
o.relativenumber = true
o.number         = true

-- Search
o.smartcase = true  -- Search case insensitive, unless the search term contains an upper case
o.hlsearch  = false -- ???
o.incsearch = true

-- Window opening
o.splitbelow = true
o.splitright = true

-- Terminal
-- Remove line numbers
vim.api.nvim_create_autocmd({'TermOpen'}, {
    pattern = '*',
    callback = function()
        vim.o.number = false
        vim.o.relativenumber = false
    end
})
