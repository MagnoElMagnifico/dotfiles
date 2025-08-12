-- TODO: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#L739
-- TODO: https://github.com/MagnoElMagnifico/dotfiles/blob/006a9ca844ada4bbfb69af8f49976d57d3f9fa41/nvim/lua/plugins/format.lua
-- TODO: https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#format-command
-- TODO: https://github.com/LazyVim/LazyVim/discussions/3734#discussioncomment-10784007
return {
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { 'black' },
        cpp = 
      },
    }
  } -- conform
} -- return
