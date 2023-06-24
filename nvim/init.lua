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

  ---- Tree Sitter ----
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

  ---- LSP ----
  use {
    'neovim/nvim-lspconfig',
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      {'j-hui/fidget.nvim', branch = 'legacy'},

      -- Additional lua configuration, makes nvim stuff amazing
      'folke/neodev.nvim', -- TODO?: remove
    },
  }

  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp', -- XXX
    requires = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  }

  -- TODO: Debug Adapter Protocol
  -- use 'mfussenegger/nvim-dap'
  -- use 'rcarriga/nvim-dap-ui'

  ---- Utilities ----
  use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
  use 'junegunn/vim-easy-align' -- Align text
  use 'tpope/vim-surround'      -- Surround stuff
  use 'numToStr/Comment.nvim'   -- Toggle comments
  use 'tpope/vim-sleuth'        -- Detect tabstop and shiftwidth automatically

  ---- Git related plugins ----
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  ---- Colorshemes: https://vimcolorschemes.com/ ----
  use 'navarasu/onedark.nvim'                -- OneDark (inspired by Atom)
  use 'Mofiqul/dracula.nvim'                 -- Dracula
  use 'sainnhe/sonokai'                      -- High constrast colorschemes
  use 'nvim-lualine/lualinenvim'             -- Fancier statusline
  use 'lukas-reineke/indent-blankline.nvim'  -- Add indentation guides even on blank lines

  if is_bootstrap then
    require('packer').sync()
  end
end)

-----------------------------------------------------------
---- Options ----------------------------------------------
-----------------------------------------------------------
-- Use Python inside Neovim
vim.g.python3_host_prog = '/usr/bin/python3'

-- File
vim.o.fileencoding = 'utf-8'
vim.o.spelllang    = 'es,en'

vim.opt.path:append('**')

vim.o.undofile = true

-- More info at :h 'list' and :h 'listchars'
vim.o.list      = true
vim.o.listchars = 'tab:>>,trail:·'

vim.o.completeopt = 'menuone,noselect'
vim.o.shortmess = 'a'

vim.o.mouse = 'a'
vim.o.termguicolors = true

vim.o.timeoutlen = 500

-- Format
vim.o.autoindent = true
vim.o.textwidth = 80
-- :h fo-table
--  t   auto wraps text
--  c   auto wraps text in comments
--  r   auto insert comment when <Enter>
--  o   auto insert comment when o or O (i_<C-u> to undo)
--  /   only insert comment when it is at the start of the line
--  q   formmating comments
--  a   automatic formatting paragraphs. Only comments if 'c' is set
--  n   recognize lists
--  2   use the second line's indent to format the rest of the paragraph
--  l   do not auto format a long line when entering insert mode
--  1   prefer breaking lines before one-letter words
--  ]   respect textwidth rigorously
--  j   remove comment leaders when joining
--  p   do not break lines at spaces that follow periods
vim.o.formatoptions = 'tcro/qnl1j'

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

-- Folds
vim.o.foldmethod     = 'indent'
vim.o.foldenable     = true
vim.o.foldlevelstart = 10
vim.o.foldnestmax    = 10

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
-- Highlight on yank. See :h vim.highlight.on_yank()
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank()
  end,
})

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
local map = function(mode, mapping, mapped, desc)
  vim.keymap.set(mode, mapping, mapped, { desc = desc })
end
vim.g.mapleader = ' '

---- Convenience changes ----
map({'n', 'v'}, '<Space>', '<Nop>')
map('n', 'U', '<C-R>', 'Redo')
map({'n', 'v'}, "'", '`')
map('i', '<C-H>', '<C-w>', 'Delete word in insert mode')

-- Moving faster in the line
map({'n', 'v', 'o'}, '+', '$', 'Go to end of line')
map({'n', 'v', 'o'}, '-', '^', 'Go to start of line')

-- NOTE: I use a EU keyboard, not US.
map({'n', 'v', 'o'}, ';', ',')     -- Repeat f, F, t, T backwards
map({'n', 'v', 'o'}, ',', ';')     -- Repeat f, F, t, T

-- Stay in visual mode after identing
map('v', '<', '<gv')
map('v', '>', '>gv')

-- TODO: Copy to tmux
-- Yank and Paste
-- map('v',        '<Leader>p', '"_dP', '[P]aste without modifying the registers')
-- map({'n', 'v'}, '<Leader>y', '"+y',  '[Y]ank to system clipboard')
-- map('n',        '<Leader>Y', '"+Y',  '[Y]ank to system clipboard')
-- map({'n', 'v'}, '<Leader>d', '"_d',  '[D]elete to void register') -- TODO: conflict with debugging

---- Commands ----
map('n', '<Leader>x', vim.cmd.bdel,  'Delete current buffer')
-- map('n', '<Leader>w', vim.cmd.write, '[W]rite current buffer')

---- Centering cursor ----
map({'n', 'v'}, 'n', 'nzz')
map({'n', 'v'}, 'N', 'Nzz')

map({'n', 'v'}, '<C-b>', '<C-b>zz')
map({'n', 'v'}, '<C-f>', '<C-f>zz')
map({'n', 'v'}, '<C-d>', '<C-d>zz')
map({'n', 'v'}, '<C-u>', '<C-u>zz')

---- Windows & Buffers & Tabs ----
map({'n', 'v'}, 'ñ', '<C-w>', 'Window command')
map({'n', 'v'}, 'Ñ', '<C-w>', 'Window command')
map({'n', 'v'}, '<C-Right>', vim.cmd.bnext,     'Next buffer')
map({'n', 'v'}, '<C-Left>',  vim.cmd.bprevious, 'Previous buffer')

-- Scroll
map({'n', 'v'}, '<C-k>', '<C-y>', 'Scroll up')
map({'n', 'v'}, '<C-j>', '<C-e>', 'Scroll down')

---- Exiting ----
map('t', '<Esc>', '<C-\\><C-n>', 'Exit terminal')    -- Exit terminal
map('t', 'jk',    '<C-\\><C-n>', 'Exit terminal')
map('t', 'kj',    '<C-\\><C-n>', 'Exit terminal')
map('i', 'jk',    '<Esc>',       'Exit insert mode') -- Exit insert mode
map('i', 'kj',    '<Esc>',       'Exit insert mode')

---- Terminal moving ----
map('t', '<C-w>j', '<C-\\><C-n><C-w>j')
map('t', '<C-w>k', '<C-\\><C-n><C-w>k')
map('t', '<C-w>h', '<C-\\><C-n><C-w>h')
map('t', '<C-w>l', '<C-\\><C-n><C-w>l')

-- TODO: Not working
-- Move text
--map('n', '<A-j>', function() vim.cmd.move('+1') end)
--map('n', '<A-k>', function() vim.cmd.move('-2') end)
--map('v', 'J', "<CMD>move '>+1<Enter>gv=gv")
--map('v', 'K', "<CMD>move '<-2<Enter>gv=gv")
