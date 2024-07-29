return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
      preset = 'helix',
      triggers = {
        { '<auto>', mode = 'nxsot' },

        --- Window commands ---
        -- TODO: Does not work
        { 'Ñ', mode = 'nxsot' },
        { 'ñ', mode = 'nxsot' },
        { ';', mode = 'nxsot' },
      },
    },

    spec = {
      { '<Leader>e', group = 'Explorer' },
      { '<Leader>d', group = 'Debug' },
      { '<Leader>s', group = 'Search' },
      { '<Leader>l', group = 'LSP' },
    },

    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Local Buffer Keymaps",
      },
    },
  },
} -- return
