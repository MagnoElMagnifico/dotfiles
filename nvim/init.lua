-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  vim.cmd [[ packadd packer.nvim ]]
end

-- Install plugins
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- LSP Configuration & Plugins
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      'j-hui/fidget.nvim',

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim', -- TODO?: remove
    },
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  -- Tree Sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }

  use {
    -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
  }

  -- Telescope
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }

  use 'tpope/vim-surround'

  -- Git related plugins
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'lewis6991/gitsigns.nvim'

  use 'nvim-lualine/lualine.nvim'            -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim'  -- Add indentation guides even on blank lines
  use 'numToStr/Comment.nvim'                -- "gc" to comment visual regions/lines
  use 'tpope/vim-sleuth'                     -- Detect tabstop and shiftwidth automatically

  -- Colorshemes: https://vimcolorschemes.com/
  use 'navarasu/onedark.nvim'                -- Theme inspired by Atom

  if is_bootstrap then
    require('packer').sync()
  end
end)

-----------------------------------------------------------
---- Colorscheme ------------------------------------------
-----------------------------------------------------------

local onedark = require('onedark')
onedark.setup { style = 'warmer' }  -- dark, darker, cool, deep, warm, warmer, light
onedark.load()

-----------------------------------------------------------
---- Options ----------------------------------------------
-----------------------------------------------------------
-- File
vim.o.fileencoding = 'utf-8'
vim.o.spelllang    = 'es,en'

vim.opt.path:append('**')

vim.o.undofile = true

-- More info at :h 'list' and :h 'listchars'
vim.o.list      = true
vim.o.listchars = 'tab:>>,trail:·'

vim.o.completeopt = 'menuone,noselect' -- Under test

vim.o.mouse = 'a'
vim.o.termguicolors = true

vim.o.timeoutlen = 500

-- Indent
vim.o.autoindent  = true
vim.o.expandtab   = true
vim.o.smartindent = true
vim.o.tabstop     = 4
vim.o.shiftwidth  = 4      -- For << and >>

-- Wrap
vim.o.breakindent = true   -- Under test
vim.o.wrap        = false
vim.o.showbreak   = '\\'   -- Wrapped text

-- Scroll
vim.o.scrolloff     = 4
vim.o.sidescrolloff = 4

-- Line numbers
vim.o.relativenumber = true
vim.o.number         = true

-- Search
vim.o.smartcase  = true  -- Search case insensitive, unless the search term contains an upper case
vim.o.ignorecase = true
vim.o.hlsearch   = false -- No highlight
vim.o.incsearch  = true

-- Window opening
vim.o.splitbelow = true
vim.o.splitright = true

-----------------------------------------------------------
---- Auto Commands ----------------------------------------
-----------------------------------------------------------
-- Terminal: Remove line numbers
vim.api.nvim_create_autocmd({'TermOpen'}, {
  pattern = '*',
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
  end
})

-- Highlight on yank. See :h vim.highlight.on_yank()
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace
-- vim.api.nvim_create_autocmd({"BufWritePre"}, {
--     pattern = "*",
--     command = "%s/\\s\\+$//e",
-- })

-----------------------------------------------------------
---- Remaps -----------------------------------------------
-----------------------------------------------------------
-- Modes
--   n    Normal
--   i    Insert
--   c    Command
--   v    Visual and Select
--   x    Visual
--   s    Select
--   t    Terminal (insert mode inside of a terminal)
local map = vim.keymap.set
vim.g.mapleader = ' '

map({'n', 'v'}, '<Space>', '<Nop>')

-- Moving faster in the line
map({'n', 'v'}, '+', '$', { desc = 'MAGNO: Goto end of line' })
map({'n', 'v'}, '-', '^', { desc = 'MAGNO: Goto start of line' })

map('i', '<C-H>', '<C-w>', { desc = 'MAGNO: Delete word in Insert Mode' })
map('n', 'U',     '<C-R>', { desc = 'MAGNO: Redo'})

-- Stay in visual mode after identing
map('v', '<', '<gv', { desc = 'MAGNO: Stay in visual mode after identing' })
map('v', '>', '>gv', { desc = 'MAGNO: Stay in visual mode after identing' })

map({'n', 'v'}, "'", '`', { desc = 'MAGNO: Jump to '})

-- NOTE: I use a EU keyboard, not US.
map({'n', 'v'}, ';', ',')     -- Repeat f, F, t, T backwards
map({'n', 'v'}, ',', ';')     -- Repeat f, F, t, T

-- Yank and Paste
-- TODO: Copy to tmux
map('v', '<Leader>p', '"_dP')
map('n', '<Leader>Y', '"+Y')
map({'n', 'v'}, '<Leader>y', '"+y')   -- Yank to system clipboard
map({'n', 'v'}, '<Leader>d', '"_d')   -- Delete to no register

---- Commands ----
-- Refactor symbol (reName)
map('n', '<Leader>n', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>') -- Under test
map('n', '<Leader>x', vim.cmd.bdel)
map('n', '<Leader>w', vim.cmd.write)

-- Scroll
map({'n', 'v'}, '<C-k>', '<C-y>') -- Scroll
map({'n', 'v'}, '<C-j>', '<C-e>')

---- Centering cursor ----
map({'n', 'v'}, 'n', 'nzz')
map({'n', 'v'}, 'N', 'Nzz')

map({'n', 'v'}, '<C-b>', '<C-b>zz')
map({'n', 'v'}, '<C-f>', '<C-f>zz')
map({'n', 'v'}, '<C-d>', '<C-d>zz')
map({'n', 'v'}, '<C-u>', '<C-u>zz')

---- Windows & Buffers & Tabs ----
map({'n', 'v'}, 'ñ', '<C-w>')
map({'n', 'v'}, 'Ñ', '<C-w>')
map('n', '<C-Right>', vim.cmd.tabn) -- Move between tabs
map('n', '<C-Left>',  vim.cmd.tabp)

---- Exiting ----
map('t', '<Esc>', '<C-\\><C-N>')    -- Exit terminal
map('t', 'jk',    '<C-\\><C-N>')
map('t', 'kj',    '<C-\\><C-N>')
map('i', 'jk',    '<Esc>')          -- Exit insert mode
map('i', 'kj',    '<Esc>')

-- TODO: Not working
-- Move text
--map('n', '<A-j>', function() vim.cmd.move('+1') end)
--map('n', '<A-k>', function() vim.cmd.move('-2') end)
--map('v', 'J', "<CMD>move '>+1<Enter>gv=gv")
--map('v', 'K', "<CMD>move '<-2<Enter>gv=gv")
