-- TODO: Run terminal command faster

------------------------------
---- Util functions ----------
------------------------------
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

vim.g.mapleader = ' ' 

------------------------------
---- Plugins -----------------
------------------------------
vim.cmd [[ packadd packer.nvim ]]

require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-surround'
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
end)

-- Telescope
map('n', '<Leader>f', '<CMD>Telescope find_files<Enter>')
map('n', '<Leader>g', '<CMD>Telescope live_grep<Enter>')

map('n', '<Leader>tr', '<CMD>Telescope registers<Enter>')
map('n', '<Leader>tb', '<CMD>Telescope buffers<Enter>')
map('n', '<Leader>tm', '<CMD>Telescope marks<Enter>')

map('n', '<Leader>th', '<CMD>Telescope manpages<Enter>')
map('n', '<Leader>gs', '<CMD>Telescope git_status<Enter>')

-- Netrw
vim.cmd [[ let g:netrw_liststyle = 1 ]] -- LONG: Extra details

------------------------------
---- Key Maps ----------------
------------------------------

---- ??? ----
--map('nvx', '0', '^') -- ???
map('nvx', '=', '$') -- ???

---- Commands ----
map('n', '<Leader>ee', '<CMD>Ex<Enter>') -- Show files -- TODO: Bind others: Tex Lex Sex Bex etc
map('n', '<Leader>eh', '<CMD>Lex 20<Enter>')

-- Obsolete by Telescope
map('n', '<Leader>r', '<CMD>reg<Enter>') -- Show current registers
map('n', '<Leader>b', '<CMD>buffers<Enter>') -- Show active buffers
map('n', '<Leader>m', '<CMD>marks<Enter>') -- Show current marks

map('n', '<Leader>d', '<CMD>bdel<Enter>')
map('n', '<Leader>n', '<CMD>noh<Enter>')
map('n', '<Leader>w', '<CMD>w<Enter>')
map('n', '<Leader>q', '<CMD>qa<Enter>') -- Dangerous & confusing with ñq

---- Misc ----
map('i', '<C-H>', '<C-w>')
map('n', 'U',     '<C-R>')  -- Redo with U
map('n', 'vv',    '<C-v>')

map('v', '<', '<gv') -- Stay in visual mode
map('v', '>', '>gv')

map('nvx', "'", '`')

-- NOTE: I use a EU keyboard, not US.
map('nvx', ';', ',') -- Repeat f, F, t, T backwards
map('nvx', ',', ';') -- Repeat f, F, t, T

-- TODO: Not working
--map('nv', '<A-j>', '<CMD>move .+1<Enter>') -- Move text
--map('nv', '<A-k>', '<CMD>move .-2<Enter>')
--map('x',  '<A-j>', "<CMD>move '>+1<Enter>gv")
--map('x',  '<A-k>', "<CMD>move '<-2<Enter>gv")

map('nvx', '<C-k>', '<C-y>') -- Scroll
map('nvx', '<C-j>', '<C-e>')

---- Centering cursor ----
map('nvx', 'n', 'nzz')
map('nvx', 'N', 'Nzz')

map('nvx', '<C-f>', '<C-f>zz')
map('nvx', '<C-b>', '<C-b>zz')
map('nvx', '<C-u>', '<C-u>zz')
map('nvx', '<C-d>', '<C-d>zz')

---- Windows & Buffers ----
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

map('n', '<C-Right>', '<CMD>tabn<Enter>') -- Move between tabs
map('n', '<C-Left>',  '<CMD>tabp<Enter>')

map('n', '<C-Down>', '<CMD>bnext<Enter>') -- Move between buffers -- TODO: Problems in Netrw
map('n', '<C-Up>',   '<CMD>bprevious<Enter>')

---- Exiting ----
map('t', '<Esc>', '<C-\\><C-N>') -- Exit terminal
map('t', 'jk',    '<C-\\><C-N>')
map('t', 'kj',    '<C-\\><C-N>')
map('i', 'jk',    '<Esc>') -- Exit insert mode
map('i', 'kj',    '<Esc>')

------------------------------
---- Autocommands ------------
------------------------------

-- Remove trailing whitespace
vim.cmd [[ autocmd BufWritePre * :%s/\[\s\n\]\+$//e ]]

------------------------------
---- Options -----------------
------------------------------
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
