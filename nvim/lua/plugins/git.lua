return {
  {
    "NeogitOrg/neogit",

    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",  -- Diff integration
      "nvim-telescope/telescope.nvim",
    },

    config = true,

    keys = {
      { '<Leader>G', ':Neogit<CR>', desc = 'Open Neo[G]it' }
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
    },
  },

} -- return
