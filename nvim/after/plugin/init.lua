---- Plugin config ----
local map = vim.keymap.set

-- NOTE: Leader commands already used:
--     p, Y, y, d, c, x, w


---- Netrw <Leader>e ----
-- More info :h netrw-quickmap and :NetrwSettings
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20

-- More mappings :h netrw-quickhelp
map('n', '<Leader>ee', vim.cmd.Ex)       -- Explorer
map('n', '<Leader>et', vim.cmd.Tex)      -- Explorer in new Tab
map('n', '<Leader>ev', vim.cmd.Lex)      -- Explorer left (vertical)


---- Telescope: <Leader>t ----
-- More info:
-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim#pickers

-- Files
local tl = require('telescope.builtin')
map('n', '<Leader>g', tl.git_files)      -- Git files
map('n', '<Leader>a', tl.find_files)     -- All files
map('n', '<Leader>s', tl.live_grep)      -- Search files

-- Vim
map('n', '<Leader>r', vim.cmd.reg)      -- Registers TODO: Telescope not working
map('n', '<Leader>b', tl.buffers)       -- Buffers
map('n', '<Leader>m', tl.marks)         -- Marks

map('n', '<Leader>tt', tl.builtin)       -- Telescope Pickers
map('n', '<Leader>to', tl.oldfiles)      -- Telescope Old files
map('n', '<Leader>ts', tl.spell_suggest) -- Telescope Spell check under cursor
map('n', '<Leader>tm', tl.man_pages)     -- Telescope Man pages
map('n', '<Leader>th', tl.help_tags)     -- Telescope Help

-- TODO: Telescope LSP
-- lsp_references                  Lists LSP references for word under the cursor
-- lsp_incoming_calls              Lists LSP incoming calls for word under the cursor
-- lsp_outgoing_calls              Lists LSP outgoing calls for word under the cursor
-- lsp_document_symbols            Lists LSP document symbols in the current buffer
-- lsp_workspace_symbols           Lists LSP document symbols in the current workspace
-- lsp_dynamic_workspace_symbols   Dynamically Lists LSP for all workspace symbols
-- diagnostics                     Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
-- lsp_implementations             Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
-- lsp_definitions                 Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
-- lsp_type_definitions            Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope

-- Git
map('n', '<Leader>tgs', tl.git_status)   -- Telescope Git Status
map('n', '<Leader>tgc', tl.git_bcommits) -- Telescope Git Commits
map('n', '<Leader>tgb', tl.git_branches) -- Telescope Git Branches

--require('telescope').setup {
--        file_ignore_patterns = {"build", "target", "nbproject"}
--    defaults = {}
-- }


---- Tree Sitter ----
-- More info at https://github.com/nvim-treesitter/nvim-treesitter
-- :so to apply changes
require('nvim-treesitter.configs').setup {
  ensure_installed = { "help", "c", "lua", "rust" }, -- TODO: Markdown

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}


---- LSP ----
-- TODO: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.setup()

-- Improve completing: https://github.com/SpaceVim/SpaceVim/pull/4692/commits/cddd363b04624f991b5b465e2b499930515b78c3

-- ThePrimeagen config
--lsp.ensure_installed {
--    'rust_analyzer',
--    'clangd'
--}

---- Mappings
--local cmp = require('cmp')
--local cmp_select = { behavior = cmp.SelectBehavior.Select }
--local cmp_mappings = lsp.defaults.cmp_mappings {
--    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--    ['<C-y>'] = cmp.mapping.confirm( { select = true } ),
--    ['<C-Space>'] = cmp.mapping.complete()
--}

--lsp.setup_nvim_cmp { mapping = cmp_mappings }

--lsp.set_preferences {
--    suggest_lsp_servers = false,
--    sign_icons = {
--        error = 'E',
--        warn  = 'W',
--        hint  = 'H',
--        info  = 'I'
--    }
--}

--lsp.on_attach(function(client, bufnr)
--  if client.name == "eslint" then
--      vim.cmd.LspStop('eslint')
--      return
--  end

--  local opts = {buffer = bufnr, remap = false}
--  map("n", "gd",          vim.lsp.buf.definition,       opts)
--  map("n", "K",           vim.lsp.buf.hover,            opts)
--  map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
--  map("n", "<leader>vd",  vim.diagnostic.open_float,    opts)
--  map("n", "[d",          vim.diagnostic.goto_next,     opts)
--  map("n", "]d",          vim.diagnostic.goto_prev,     opts)
--  map("n", "<leader>vca", vim.lsp.buf.code_action,      opts)
--  map("n", "<leader>vrr", vim.lsp.buf.references,       opts)
--  map("n", "<leader>vrn", vim.lsp.buf.rename,           opts)
--  map("i", "<C-h>",       vim.lsp.buf.signature_help,   opts)
--end)

--lsp.setup()
--vim.diagnostic.config { virtual_text = true }
