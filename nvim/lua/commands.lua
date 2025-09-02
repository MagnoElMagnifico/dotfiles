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

-- :Size <width> [<height>]
--     -    Leaves as it is
--     N    Sets
--    +N    Increases
--    -N    Decreases
--    %N    Percentaje relative to full window size
vim.api.nvim_create_user_command('Size', function(args)
  if #args.fargs < 1 then
    error('One argument must be provided')
  end

  local width = args.fargs[1]
  if width ~= '-' then
    if width:sub(1, 1) == '%' then
      width = math.floor(width:sub(2, -1) / 100 * vim.o.columns)
    end
    vim.cmd('vertical resize ' .. width)
  end

  if #args.fargs < 2 then
    return
  end

  local height = args.fargs[2]
  if height ~= '-' then
    if height:sub(1, 1) == '%' then
      height = math.floor(height:sub(2, -1)/100 * vim.o.lines)
    end
    vim.cmd.resize(height)
  end
end, { desc = 'Resize window', bang = false, nargs='+'})

vim.api.nvim_create_user_command('Go', function(args)
  local line = nil
  local column = nil

  if #args.fargs == 1 then
    local matches =  string.gmatch(args.args, '%d+')
    line = matches()
    column = matches()
    -- Maybe this is innecessary
    if matches() ~= nil then
      error('Too many numbers')
    end
  elseif  #args.fargs == 2 then
    line = args.fargs[1]
    column = args.fargs[2]
  else
    error('Too many arguments')
  end

  line = tonumber(line)
  column = tonumber(column)
  if line == nil or column == nil then
    error('Arguments are not numbers')
  end

  vim.cmd.normal(line .. 'G' .. column .. '|')
end, { desc = 'Go to location inside current file', bang = false, nargs='+' })




--[[
vim.keymap.set("x", "<leader>0", function()
  local start_line = vim.fn.getpos("'<")[2]
  local end_line   = vim.fn.getpos("'>")[2]

  if end_line < start_line then
    start_line, end_line = end_line, start_line
  end

  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  if #lines == 0 then return end

  local text_width = vim.bo.textwidth > 0 and vim.bo.textwidth or 80

  print(vim.inspect(lines))

  for _, line in ipairs(lines) do
      local _, _, indent_width, bullet, extra_indent, text = string.find(line, '^(%s*)([-*+])(%s+)(.*)')
      if indent_width then

        indent_width = #indent_width
        extra_indent = #extra_indent

        print(indent_width .. ': ' .. text)

        if #line > text_width then
          print('acortar')
        end

      end
  end

end, { desc = "Format selected list item" })

  local function flush_buffer()
    if #buffer == 0 then return end
    local _, _, ind, bul, rest = string.find(buffer[1], "^(%s*)([-*+])%s+(.*)")
    if not bul then
      vim.list_extend(formatted, buffer)
      buffer = {}
      return
    end
    indent, bullet = ind, bul
    local indent_str = indent .. string.rep(" ", 4)

    -- une todo el contenido
    local text = rest
    for i = 2, #buffer do
      text = text .. " " .. buffer[i]
    end
    text = text:gsub("%s+", " ")

    -- wrap manual respetando `width`
    local wrapped = {}
    local line = ""
    for word in text:gmatch("%S+") do
      if #line + #word + 1 > width then
        table.insert(wrapped, line)
        line = word
      else
        if line == "" then
          line = word
        else
          line = line .. " " .. word
        end
      end
    end
    if line ~= "" then
      table.insert(wrapped, line)
    end

    -- reconstruye líneas
    wrapped[1] = indent .. bullet .. "   " .. wrapped[1]
    for i = 2, #wrapped do
      wrapped[i] = indent_str .. wrapped[i]
    end

    vim.list_extend(formatted, wrapped)
    buffer = {}
  end

  for _, l in ipairs(lines) do
    if l:match("^%s*[-*+]%s+") then
      flush_buffer()
    end
    table.insert(buffer, l)
  end
  flush_buffer()

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, formatted)
end
vim.keymap.set("v", "<leader>t", format_list_selection, { desc = "Format selected list item" })
--]]
