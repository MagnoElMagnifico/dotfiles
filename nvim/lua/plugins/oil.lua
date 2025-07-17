return {
  {
    'stevearc/oil.nvim',

    lazy = true,
    cmd = 'Oil',
    event = 'VimEnter',
    keys = {
      { '<Leader>-', '<cmd>Oil<Enter>',  desc = 'Open Explorer in parent directory' },
      { '<Leader>_', function() require('oil').open(vim.uv.cwd()) end,  desc = 'Open Explorer in CWD' },
    },

    opts = {
      default_file_explorer = true,

      -- See :help oil-columns
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },

      keymaps = {
        ['<C-h>'] = false,
        ['<C-b>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },

        ['<C-l>'] = false,
        ['<C-r>'] = 'actions.refresh',
      },

      view_options = {
        show_hidden = true,
      },
    },
  },
}
