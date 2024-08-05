return {
  {
    "folke/which-key.nvim",

    event = "VeryLazy",

    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Local Buffer Keymaps", },
    },

    opts = {
      preset = 'helix',
      spec = {
        { '<Leader>e', group = 'Explorer' },
        { '<Leader>d', group = 'Debug' },
        { '<Leader>s', group = 'Search' },
        { '<Leader>l', group = 'LSP' },
      },
    }, -- opts

  },
} -- return
