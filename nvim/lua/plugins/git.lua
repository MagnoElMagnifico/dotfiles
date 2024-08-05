return {
  {
    "NeogitOrg/neogit",

    lazy = true,
    cmd = 'Neogit',
    keys = {
      { '<Leader>G', '<cmd>Neogit<CR>', desc = 'Open NeoGit' }
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",  -- Diff integration
      "nvim-telescope/telescope.nvim",
    },

    config = true,
  },

  {
    'lewis6991/gitsigns.nvim',

    lazy = true,
    cmd = 'Gitsigns',
    event = 'BufEnter',

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
    }, -- opts
  },

} -- return
