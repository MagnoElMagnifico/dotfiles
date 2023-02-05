-----------------------------------------------------------
---- LSP Settings -----------------------------------------
-----------------------------------------------------------
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open diagnostic in a floating window' })
vim.keymap.set('n', 'gq', vim.diagnostic.setloclist, { desc = 'Open all the diagnostics in a quickfix window' }) -- TODO: find better mapping
vim.diagnostic.config { virtual_text = true } -- Show errors (under test)

-- TODO: Telescope LSP
--
-- [x] lsp_references                  Lists LSP references for word under the cursor
--
-- [ ] lsp_incoming_calls              Lists LSP incoming calls for word under the cursor
-- [ ] lsp_outgoing_calls              Lists LSP outgoing calls for word under the cursor
--
-- [x] lsp_document_symbols            Lists LSP document symbols in the current buffer
-- [ ] lsp_workspace_symbols           Lists LSP document symbols in the current workspace
-- [x] lsp_dynamic_workspace_symbols   Dynamically Lists LSP for all workspace symbols
--
-- [ ] diagnostics                     Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
--
-- [ ] lsp_implementations             Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
-- [ ] lsp_definitions                 Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
-- [ ] lsp_type_definitions            Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- We create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local tl = require 'telescope.builtin'
  local vlb = vim.lsp.buf

  nmap('K',     vlb.hover,      'Hover Documentation')
  nmap('<C-k>', vlb.signature_help, 'Signature Documentation') -- TODO: better mapping

  nmap('<Leader>rn', vlb.rename,          '[R]e[n]ame')
  nmap('<Leader>ca', vlb.code_action,     '[C]ode [A]ction')
  nmap('<Leader>D',  vlb.type_definition, 'Type [D]efinition')

  nmap('<Leader>ds', tl.lsp_document_symbols,          '[D]ocument [S]ymbols')
  nmap('<Leader>ws', tl.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap('gd', vlb.definition,     '[G]oto [D]efinition')
  nmap('gD', vlb.declaration,    '[G]oto [D]eclaration')
  nmap('gI', vlb.implementation, '[G]oto [I]mplementation')
  nmap('gr', tl.lsp_references,  '[G]oto [R]eferences')

  -- Lesser used LSP functionality
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-----------------------------------------------------------
---- Others -----------------------------------------------
-----------------------------------------------------------
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- Setup neovim lua configuration
require('neodev').setup()
-- Turn on lsp status information
require('fidget').setup()

-----------------------------------------------------------
---- MASON ------------------------------------------------
-----------------------------------------------------------
-- LSP servers
local servers = {
  clangd = {},
  rust_analyzer = {},
  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

require('mason').setup()
local mason_lspconfig = require 'mason-lspconfig'

-- Ensure the servers above are installed
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-----------------------------------------------------------
---- NVIM-CMP ---------------------------------------------
-----------------------------------------------------------
local cmp = require 'cmp'
local luasnip = require 'luasnip'
cmp.setup {
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end, },
  mapping = cmp.mapping.preset.insert {
    ['<C-a>'] = cmp.mapping.complete(), -- Open complete menu
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<Enter>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- Tab: select item or complete snippet
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },

  -- Sources (completion options)
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- TODO?: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
  },
}
