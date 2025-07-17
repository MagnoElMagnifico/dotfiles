-- Here you can disable LSP fallback for specific filetypes.
local disable_filetypes = {
  lua = true,
}

vim.api.nvim_create_user_command("AutoformatToggle", function(args)
  if args.bang then
    -- With the AutoformatToggle! will disable for the local buffer
    vim.b.enable_autoformat = not vim.b.enable_autoformat
  else
    vim.g.enable_autoformat = not vim.g.enable_autoformat
  end
end, { desc = "Toggle autoformat on file save", bang = true })

return {
  {
    'stevearc/conform.nvim',

    lazy = true,
    event = 'BufWrite',  -- Load before writting a buffer so it can be formatted
    cmd = 'ConformInfo', -- Also load when trying to run this command

    keys = {
      {
        '<Leader>F',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = { 'n', 'v' },
        desc = 'Format buffer'
      },
    },

    opts = {
      notify_on_error = false,

      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.enable_autoformat or vim.b[bufnr].enable_autoformat then
          return {
            timeout_ms = 500,
            lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
          }
        end
      end,

      formatters_by_ft = {
        lua = { 'stylua' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        rust = { 'rustfmt' },
        python = { 'black' },
      },
    }, -- opts
  },
} -- return
