-------------------------------------------------------------------------------
---- LANGUAGE SERVER PROTOCOL -------------------------------------------------
-------------------------------------------------------------------------------
-- LSP (Language Server Protocol) is a protocol that standardizes how editors
-- and language tooling communicate.
--
-- In general, you have a server (a standalone process) running some tool that
-- understands your code and provides features like error reporting,
-- auto-completion, go-to-definition, find-references, and more. This is
-- language-specific, so you'll have different servers for different programming
-- languages.
--
-- However, this server is not part of Neovim itself, so they need to
-- communicate using an agreed-upon protocol in order to display that
-- information to you.
--
-- Since Neovim 0.11, the API is easier to use and LSPs can be setup natively
-- with almost no boilerplate code. See below for more information.
--
---- LSP KEYMAPS --------------------------------------------------------------
-- Sets up keymaps for the buffer with an LSP Server attached.
-- These are the default keymaps, see ':h lsp-defaults'.
local function keymaps(buffer, client)

  local function map(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = buffer, desc = 'LSP: ' .. desc })
  end

  local tl = require 'telescope.builtin'

  ---- Actions ----
  map('grn', vim.lsp.buf.rename, 'Rename symbol under cursor')
  map('gra', vim.lsp.buf.code_action, 'Code Action')
  map('gq',  vim.lsp.buf.format, 'Format with LSP')

  ---- Navigation ----
  map('grr', tl.lsp_references,                'Goto References of word under cursor')
  map('gri', tl.lsp_implementations,           'Goto Implementation of word under cursor')
  map('grt', tl.lsp_type_definitions,          'Goto Type definition under cursor')
  map('gd',  tl.lsp_definitions,               'Goto Definition') -- First declaration, to go back use '<C-t>'
  map('gD',  vim.lsp.buf.declaration,          'Goto Declaration') -- Jump to header file (not very used)
  map('gO',  tl.lsp_document_symbols,          'Document symbols')
  map('gW',  tl.lsp_dynamic_workspace_symbols, 'Workspace symbols')

  map('gs',    vim.lsp.buf.signature_help, 'Function Signature')
  map('<C-s>', vim.lsp.buf.signature_help, 'Function Signature', 'i')

  ---- Diagnostics ----
  map('K',          vim.lsp.buf.hover,         'Hover Documentation of symbol under cursor')
  map('gl',         vim.diagnostic.open_float, 'Open diagnostic in a floating window')
  map('<Leader>lt', tl.diagnostics,            'Telescope Quickfix diagnostics')
  map('<leader>ll', vim.diagnostic.setloclist, 'Open all diagnostics in a Location List')

  map('[d', vim.diagnostic.goto_prev, 'Go to previous Diagnostic message')
  map(']d', vim.diagnostic.goto_next, 'Go to next Diagnostic message')

  ---- Other ----
  -- tl.lsp_incoming_calls
  -- tl.lsp_outgoing_calls
  -- format

  -- Toggle inlay hints in code, if the language server you are using supports
  -- them. This may be unwanted, since they displace some of your code.
  if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
    map('<Leader>li', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, 'Toggle Inlay Hints')
  end
end

---- LSP AUTOCOMMANDS ---------------------------------------------------------
local function autocommands(buffer, client)
  -- The following two autocommands are used to highlight references of the word
  -- under your cursor when your cursor rests there for a little while.
  --
  -- See `:help CursorHold` for information about when this is executed.
  --
  -- First, check if this is functionality is provided by the LSP Server.
  if client and client.server_capabilities.documentHighlightProvider then
    local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = buffer,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    -- When you move your cursor, the highlights will be cleared.
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = buffer,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    -- On exit, clear the references and these autocommands
    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
      end,
    })
  end
end

---- SERVER CONFIG ------------------------------------------------------------
-- Enable the following language servers with additional configuration options.
--
--   cmd          The command that runs the server.
--   filetypes    File types where the server will be launched.
--   capabilities Can be used to disable certain LSP features.
--   settings     Specific configurations options for the server.
--   root_markers How to choose the working directory for project.
--                If the same directory is used, we'll use the same server.
--
-- These are implemented by 'neovim/nvim-lspconfig'. Since I am using very few
-- servers, I will do them myself. However, this repo is useful as a reference.
--
--    :LspInfo     Status of active and configured servers (alias to checkhealth vim.lsp)
--    :LspLog      Open the LSP logfile
--    :LspRestart  Restarts all the servers
--
-- This generic configuration ('*') will merged for the with the others
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      semanticTokens = {
        multilineTokenSupport = true,
      },
    },
  },
  root_markers = { ".git" },
})

---- Configuration for each LSP server ----
-- Lua Language Server config
vim.lsp.config['lua_ls'] = {
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_markers = {},
  settings = {
    Lua = {
      runtime = { version = { 'LuaJIT' } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      -- diagnostics = { globals = { 'vim' } },
    },
  },
}

-- C/C++ LSP server config
vim.lsp.config['clangd'] = {
  cmd = { 'clangd', '--background-index' },
  filetypes = { 'c', 'cpp' },
  root_markers = { 'Makefile', 'CMakeLists.txt', 'compile_commands.json', 'compile_flags.txt' },
}

vim.lsp.config['rust_analyzer'] = {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', '.git' },
  -- capabilities = {
  --   experimental = {
  --     serverStatusNotification = true,
  --   }
  -- }
}

-- Odin language server
vim.lsp.config['ols'] = {
  cmd = { 'ols' },
  filetypes = { 'odin' },
  root_markers = { 'ols.json', '.git' },
}

-- Python language server
vim.lsp.config['pyright'] = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'setup.py', 'requirements.txt', '.git' },
}

-- Finally, do a call to 'vim.lsp.enable' with the name of the servers.
vim.lsp.enable({
  'clangd',
  'lua_ls',
  'ols',
  'pyright',
  'rust_analyzer',
})

-- Diagnostics config ':h vim.diagnostic.Opts'
vim.diagnostic.config {
  update_in_insert = true, -- Update LSP while in insert mode
  virtual_text = true,     -- Show diagnostics in virtual text
  severity_sort = true,    -- List important first
  underline = false,
  float = { source = 'if_many' },
}

-- Create the mappings and autocommands when an LSP is attached
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end
    -- The new buffer will have these new keymaps and autocommands
    keymaps(event.buf, client)
    autocommands(event.buf, client)
  end,
})

-- Useful commands
vim.api.nvim_create_user_command('LspInfo', 'checkhealth vim.lsp', { desc = 'Run checkhealth vim.lsp' })

vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd(string.format('tabnew %s', vim.lsp.get_log_path()))
end, { desc = 'Opens the Nvim LSP client log.' })

vim.api.nvim_create_user_command('LspRestart', function()
  vim.lsp.stop_client(vim.lsp.getclients())
  vim.cmd.edit()
end, { desc = 'Restart all the servers' })

return {
  ---- MASON --------------------------------------------------------------
  -- Note that the executables for the LSP servers should be found by Neovim.
  -- This is done by mason.nvim: allows you to easily manage external tooling
  -- such us LSP Servers, DAP Servers, Linters, Formatters, etc.; install them
  -- in the 'data' directory and add them to the PATH:
  --
  --     ~/.local/share/nvim/mason/
  --
  -- The available packages are listed here: https://mason-registry.dev/registry/list
  --
  --    :Mason                 Open GUI ('g?' for help)
  --    :MasonUpdate           Updates all managed packages
  --    :MasonInstall <pkg>    (Re-)installs some package(s)
  --    :MasonUninstall <pkg>  Uninstall the provided package(s)
  --    :MasonUninstallAll     Delete all packages
  --    :MasonLog              Opens the logfile in a new tab
  {
    'mason-org/mason.nvim',
    lazy = false, -- Needs to setup the path properly
    opts = {},
  }
}

