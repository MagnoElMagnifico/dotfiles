-- Asks for a command a runs it in a vertical split window
local map = vim.keymap.set

vim.api.nvim_set_var('magno_cmd', '')

map('n', '<Leader>cv', function()
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
end, { desc = 'Run command' })

map('n', '<Leader>ch', function()
  vim.ui.input({
    prompt = 'Command > ',
    default = nil,
    completion = 'file' -- TODO: complete as bash
  },
    function(input)
      if (not (input == nil or input == '')) then
        vim.g.magno_cmd = input
        vim.fn.execute(':split term://' .. vim.g.magno_cmd)
      end
    end)
end, { desc = 'Run command' })

-- Repeat last command
map('n', '<Leader>CV', function()
  if (not (vim.g.magno_cmd == nil or vim.g.magno_cmd == '')) then
    vim.fn.execute(':vs term://' .. vim.g.magno_cmd)
  end
end, { desc = 'Repeat last command' })

map('n', '<Leader>CH', function()
  if (not (vim.g.magno_cmd == nil or vim.g.magno_cmd == '')) then
    vim.fn.execute(':split term://' .. vim.g.magno_cmd)
  end
end, { desc = 'Repeat last command' })

