-- Here you can disable LSP fallback for specific filetypes.
local disable_filetypes = {
  lua = true,
}

return {
  {
    'stevearc/conform.nvim',
    lazy = false,

    keys = {
      {
        '<Leader>F',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = 'Format buffer'
      },
    },

    opts = {
      notify_on_error = false,

      format_on_save = function(bufnr)
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,

      formatters_by_ft = {
        lua = { 'stylua' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        rust = { 'rustfmt' },
        python = { 'black' },
      },
    },
  },
} -- return
