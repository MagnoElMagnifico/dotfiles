--
---- LSP ----
-- TODO: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
-- local lsp = require('lsp-zero')
-- lsp.preset('recommended')
-- lsp.setup()

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
-- TODO
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LSP settings.
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

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

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

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
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
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
