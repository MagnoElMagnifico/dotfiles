return {
  ---- Gitsigns ---------------------------------------------------------------
  -- Adds signs to the sign-column to indicate added, changed and deleted text
  --
  -- HUNKS (block of changes)
  --     :Gitsigns stage_hunk          Stage/Unstage
  --     :Gitsigns reset_hunk          Revert changes
  --     :Gitsigns preview_hunk_inline See the actual changes
  --     :Gitsigns preview_hunk        Same as before, but in a pop-up window
  --     :Gitsigns nav_hunk prev/next  Navigation between changes
  --     :Gitsigns setqflist           Open quickfix window with hunks
  --     :Gitsigns setloclist          Open location list with hunks
  --
  -- GIT BLAME
  --     :Gitsigns blame               Blame of current buffer in a new window
  --     :Gitsigns blame_line          Blame current line in a pop-up
  --     :Gitsigns toggle_current_line_blame Toggle virtual text blame of the current line
  --
  -- GIT DIFF
  --     :Gitsigns change_base {rev}   Change the base commit for comparison
  --     :Gitsigns diffthis {rev}      Show diff of the current buffer
  --     :Gitsigns toggle_word_diff    Intraline word-diff
  {
    'lewis6991/gitsigns.nvim',

    lazy = true,
    event = 'BufEnter',

    opts = {},
    config = function()
      local function map(mapping, mapped, desc)
        vim.keymap.set('n', mapping, mapped, { desc = desc, silent = true })
      end

      map('[h', '<cmd>Gitsigns nav_hunk next<Enter>', 'Next hunk')
      map(']h', '<cmd>Gitsigns nav_hunk prev<Enter>', 'Previous hunk')
    end
  }, -- gitsigns

  -- {
  --   "NeogitOrg/neogit",
  --
  --   lazy = true,
  --   cmd = 'Neogit',
  --   keys = {
  --     { '<Leader>G', '<cmd>Neogit<CR>', desc = 'Open NeoGit' }
  --   },
  --
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "sindrets/diffview.nvim",  -- Diff integration
  --     "nvim-telescope/telescope.nvim",
  --   },
  --
  --   config = true,
  -- },

} -- return
