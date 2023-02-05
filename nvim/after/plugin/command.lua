-- Asks for a command a runs it in a vertical split window
local map = vim.keymap.set

vim.api.nvim_set_var('magno_cmd', '')
map('n', '<Leader>c', function()
  vim.ui.input({
    prompt = 'Command > ',
    default = nil,
    completion = 'file' -- TODO: complete as bash
  },
    function(input)
      if (not (input == nil or input == '')) then
        vim.g.magno_cmd = input
        vim.fn.execute(':vs term://' .. vim.g.magno_cmd)
      end
    end)
end)

-- Repeat last command
map('n', '<Leader>C', function()
  if (not (vim.g.magno_cmd == nil or vim.g.magno_cmd == '')) then
    vim.fn.execute(':vs term://' .. vim.g.magno_cmd)
  end
end)

-- Exit terminal
vim.api.nvim_create_autocmd({'TermOpen'}, {
  callback = function() map('n', 'q', 'i<C-D>', { buffer=true }) end
})
