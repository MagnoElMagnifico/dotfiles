-----------------------------------------------------------
---- LSP Settings -----------------------------------------
-----------------------------------------------------------
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,  { desc = 'LSP: Go to previous [D]iagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,  { desc = 'LSP: Go to next [D]iagnostic' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = '[L]SP: Open diagnostic in a floating window' })
vim.keymap.set('n', 'gq', vim.diagnostic.setloclist, { desc = 'LSP: Open all the diagnostics in a [Q]uickFix window' })
vim.diagnostic.config { virtual_text = true, severity_sort = true, float = { source = 'if_many' } }

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- We create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local tl = require 'telescope.builtin'
  local vlb = vim.lsp.buf

  nmap('gd', vlb.definition,     'LSP: [G]oto [D]efinition')
  nmap('gD', vlb.declaration,    'LSP: [G]oto [D]eclaration')
  nmap('gI', vlb.implementation, 'LSP: [G]oto [I]mplementation')
  nmap('gr', tl.lsp_references,  'LSP: Telescope [G]oto [R]eferences')

  nmap('K',          vlb.hover,           'LSP: Hover Documentation')
  nmap('<Leader>ld', vlb.signature_help,  '[L]SP: Signature [D]ocumentation')
  nmap('<Leader>lr', vlb.rename,          '[L]SP: [R]ename')
  nmap('<Leader>lc', vlb.code_action,     '[L]SP: [C]ode Action')
  nmap('<Leader>lt', vlb.type_definition, '[L]SP: [T]ype Definition')

  nmap('<Leader>q',  tl.diagnostics,                   'LSP: Telescope [Q]uickfix diagnostics')
  nmap('<Leader>ls', tl.lsp_document_symbols,          '[L]SP: Telescope Document [S]ymbols')
  nmap('<Leader>lw', tl.lsp_dynamic_workspace_symbols, '[L]SP: Telescope [W]orkspace Symbols')

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
-- require('neodev').setup()
-- -- Turn on lsp status information
-- require('fidget').setup()

-----------------------------------------------------------
---- MASON ------------------------------------------------
-----------------------------------------------------------

-- LSP servers
local servers = {
  pylsp = {
    pylsp = { -- it wont work without this extra level
      plugins = {
        pycodestyle = { ignore = 'E501' },
        flake8 = { enabled = true, ignore = 'E501' },
      }
    }
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
-- TODO
local cmp = require 'cmp'
local luasnip = require 'luasnip'
cmp.setup {
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

  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end, },
  -- TODO: https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
  -- window = { documentation = cmp.config.window.bordered() },

  -- Sources (completion options)
  -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 1},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
}

