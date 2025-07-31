---- Auto Commands ------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup('magno', { clear = true })

-- Highlight on yank. See :h vim.highlight.on_yank()
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Create directories on save if they don't exist
-- Taken from: https://github.com/radleylewis/nvim-lite/blob/youtube_demo/init.lua
vim.api.nvim_create_autocmd('BufWrite', {
  desc = 'Create directories on save',
  group = augroup,
  callback = function()
    local current_dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(current_dir) == 0 then
      vim.fn.mkdir(current_dir, 'p')
    end
  end
})

-- Configure options in terminals
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Configure terminal',
  group = augroup,
  callback = function()
    -- No numbers
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false

    -- Wrapping (in case I change the original to false)
    vim.opt_local.wrap = true
  end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('wrap_spell', { clear = true }),
  pattern = { 'gitcommit', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

---- User commands ------------------------------------------------------------

-- :Size <width> <height>
--     -    Leaves as it is
--     N    Sets
--    +N    Increases
--    -N    Decreases
--    %N    Percentaje relative to full window size
vim.api.nvim_create_user_command('Size', function(args)
  if #args.fargs ~= 2 then
    error('Two arguments must be provided')
  end

  local width = args.fargs[1]
  if width ~= '-' then
    if width:sub(1, 1) == '%' then
      width = math.floor(width:sub(2, -1) / 100 * vim.o.columns)
    end
    vim.cmd('vertical resize ' .. width)
  end

  local height = args.fargs[2]
  if height ~= '-' then
    if height:sub(1, 1) == '%' then
      height = math.floor(height:sub(2, -1)/100 * vim.o.lines)
    end
    vim.cmd.resize(height)
  end
end, { desc = 'Resize window', bang = false, nargs='+'})
