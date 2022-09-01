-- TODO: Run terminal command faster
-- Key bindings shortcut --
-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x', -- ???
--   term_mode = 't',
--   command_mode = 'c',
function map(modes, shortcut, command)
    for mode in modes:gmatch"." do
        vim.api.nvim_set_keymap(mode, shortcut, command, {noremap = true, silent = true})
    end
end

------------------
---- Key Maps ----
------------------

vim.g.mapleader = ' ' 

-- Maybe not that useful
--map('nvx', 'j', 'gj') -- Move down even when the line is wrapped
--map('nvx', 'k', 'gk')

map('nvx', '=', '$')
--map('nvx', '0', '^') -- ???

map('nvx', '<C-k>', '<C-y>') -- Scroll
map('nvx', '<C-j>', '<C-e>')

-- NOTE: I use a EU keyboard, not US.
map('nvx', ';', ',') -- Repeat f, F, t, T backwards
map('nvx', ',', ';') -- Repeat f, F, t, T

-- TODO: Not working
--map('nv', '<A-j>', '<cmd>move .+1<Enter>') -- Move text
--map('nv', '<A-k>', '<cmd>move .-2<Enter>')
--map('x',  '<A-j>', "<cmd>move '>+1<Enter>gv")
--map('x',  '<A-k>', "<cmd>move '<-2<Enter>gv")

-- Windows & Buffers --
map('nvx', 'ñ', '<C-w>')
map('nvx', 'Ñ', '<C-w>')

-- Maybe move between recent windows with <C-l> <C-h> 

map('nvx', '<Right>', '<C-w>l') -- Move between windows
map('nvx', '<Left>',  '<C-w>h')
map('nvx', '<Up>',    '<C-w>k')
map('nvx', '<Down>',  '<C-w>j')

map('nvx', '<S-Right>', '<C-w>>') -- Resize windows
map('nvx', '<S-Left>',  '<C-w><')
map('nvx', '<S-Up>',    '<C-w>+')
map('nvx', '<S-Down>',  '<C-w>-')

map('n', '<C-Right>', '<cmd>tabn<Enter>') -- Move between tabs
map('n', '<C-Left>',  '<cmd>tabp<Enter>')

map('n', '<C-Down>', '<cmd>bnext<Enter>') -- Move between buffers -- TODO: Problems in Netrw
map('n', '<C-Up>',   '<cmd>bprevious<Enter>')

-- Exiting --
map('t', '<Esc>', '<C-\\><C-N>') -- Exit terminal
map('t', 'jk',    '<C-\\><C-N>')
map('t', 'kj',    '<C-\\><C-N>')
map('i', 'jk',    '<Esc>') -- Exit insert mode
map('i', 'kj',    '<Esc>')

-- Others --
map('n', '<Leader>ee', '<cmd>Ex<Enter>') -- Show files -- TODO: Bind others: Tex Lex Sex Bex etc
map('n', '<Leader>eh', '<cmd>Lex 20<Enter>')

map('n', '<Leader>r', '<cmd>reg<Enter>') -- Show current registers
map('n', '<Leader>b', '<cmd>buffers<Enter>') -- Show active buffers
map('n', '<Leader>m', '<cmd>marks<Enter>') -- Show current marks

map('n', '<Leader>n', '<cmd>noh<Enter>')
map('n', '<Leader>d', '<cmd>redraw<Enter>')
map('n', '<Leader>w', '<cmd>w<Enter>')
map('n', '<Leader>q', '<cmd>qa<Enter>') -- Dangerous & confusing with ñq

map('nvx', 'n', 'nzz')
map('nvx', 'N', 'Nzz')

map('nvx', "'", '`')

map('i', '<C-H>', '<C-w>')
map('n', 'U',     '<C-R>')  -- Redo with U
map('n', 'vv',    '<C-v>') -- In my terminal CTRL-V pastes

map('v', '<', '<gv') -- Stay in visual mode
map('v', '>', '>gv')

----------------------
---- Autocommands ----
----------------------

-- Remove trailing whitespace
vim.cmd [[ autocmd BufWritePre * :%s/\[\s\n\]\+$//e ]]

-----------------
---- Options ----
-----------------
vim.o.fileencoding = 'utf-8'
vim.o.langmenu = 'en_US.UTF8' -- Language

vim.opt.path:append('**')

--vim.o.spell = true
vim.o.spelllang = 'es,en'

vim.o.autoindent = true    
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.o.mouse = 'a'

vim.o.wrap = true
vim.o.showbreak = '\\' -- Wrapped text

vim.o.scrolloff = 4
vim.o.sidescrolloff = 4

vim.o.relativenumber = true
vim.o.number = true
vim.o.colorcolumn = 80

vim.o.timeoutlen = 500
vim.o.cmdheight = 1

vim.o.smartcase = true  -- Search case insensitive, unless the search term contains an upper case

vim.o.splitbelow = true
vim.o.splitright = true

--------------------
-- Plugins ---------
--------------------
vim.cmd [[ packadd packer.nvim ]]
require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-surround'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
end)

-- Netrw
vim.cmd [[ let g:netrw_liststyle = 1 ]] -- LONG: Extra details
