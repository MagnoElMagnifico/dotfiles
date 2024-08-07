-------------------------------------
---- Specific server config ---------
-------------------------------------
-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local servers = {
  -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
  clangd = {},
  pyright = {},
  rust_analyzer = {},

  -- pylsp = {
  --   pylsp = { -- it wont work without this extra level
  --     plugins = {
  --       -- Ignore long lines
  --       pycodestyle = { ignore = 'E501' },
  --       flake8 = { enabled = true, ignore = 'E501' },
  --     }
  --   }
  -- },

  lua_ls = {
    -- cmd = { ... },
    -- filetypes = { ... },
    -- capabilities = {},
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        diagnostics = { globals = { 'vim' } },
      },
    },
  },
}

-------------------------------------
---- LSP keymaps --------------------
-------------------------------------
local function keymaps(event)

  local function nmap(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  local tl = require 'telescope.builtin'

  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  nmap('gd', tl.lsp_definitions, 'Goto Definition')

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  nmap('gI', tl.lsp_implementations, 'Goto Implementation')

  -- Find references for the word under your cursor.
  nmap('gr', tl.lsp_references, 'Goto References')

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  nmap('<leader>lt', tl.lsp_type_definitions, 'Type Definition')

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  nmap('<leader>ld', tl.lsp_document_symbols, 'Document Symbols')

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  nmap('<leader>lw', tl.lsp_dynamic_workspace_symbols, 'Workspace Symbols')

  -- Rename the variable under your cursor.
  --  Most Language Servers support renaming across files, etc.
  nmap('<leader>lr', vim.lsp.buf.rename, 'Rename')

  -- Execute a code action, usually your cursor needs to be on top of an error
  -- or a suggestion from your LSP for this to activate.
  nmap('<leader>la', vim.lsp.buf.code_action, 'Code Action')

  -- Opens a popup that displays documentation about the word under your cursor
  --  See `:help K` for why this keymap.
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

  nmap('[d', vim.diagnostic.goto_prev, 'Go to previous Diagnostic message')
  nmap(']d', vim.diagnostic.goto_next, 'Go to next Diagnostic message')
  nmap('gl', vim.diagnostic.open_float, 'Open diagnostic in a floating window')
  nmap('gq', vim.diagnostic.setloclist, 'Open all diagnostics in a QuickFix window')
  nmap('<Leader>ll', tl.diagnostics, 'Telescope Quickfix diagnostics')
  nmap('<leader>lf', vim.lsp.buf.signature_help, 'Function signature')

  -- -- Lesser used LSP functionality
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, 'Workspace List Folders')
end


------------------------------------------
---- LSP autocommands --------------------
------------------------------------------
local function autocommands(event)

  local function nmap(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  -- The following two autocommands are used to highlight references of the
  -- word under your cursor when your cursor rests there for a little while.
  --    See `:help CursorHold` for information about when this is executed
  --
  -- When you move your cursor, the highlights will be cleared (the second autocommand).
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.server_capabilities.documentHighlightProvider then
    local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
      end,
    })
  end

  -- The following autocommand is used to enable inlay hints in your
  -- code, if the language server you are using supports them
  --
  -- This may be unwanted, since they displace some of your code
  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    nmap('<Leader>li', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, 'Toggle Inlay Hints')
  end
end

return {
  {
    'neovim/nvim-lspconfig',

    lazy = true,
    event = 'VimEnter',

    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful updates for LSP
      { 'j-hui/fidget.nvim', opts = {} }
    },

    config = function()
      -- Create a function that runs when a LSP attachs to a particular buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- The new buffer will have these new keymaps and autocommands
          keymaps(event)
          autocommands(event)

          -- Other config
          vim.diagnostic.config {
            virtual_text = true,
            severity_sort = true,
            float = { source = 'if_many' }
          }
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Ensure the servers and tools are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      require('mason-tool-installer').setup {
        ensure_installed = vim.tbl_keys(servers or {})
      }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}

            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        }
      }
    end -- config
  }
} -- return
