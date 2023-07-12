-- Asks for a command and runs it in a vertical split window
vim.api.nvim_set_var('magno_cmd', '')

local function term_cmd(split, cmd, opts)
    if (#opts.fargs ~= 0) then
      vim.g.magno_cmd = table.concat(opts.fargs, ' ')
    end

    if (opts.bang) then
      vim.fn.execute(':' .. split .. ' | term ')
    else
      vim.fn.execute(':' .. split .. ' | term ' .. cmd)
    end
end

local attributes = { nargs = '*', complete = 'shellcmd', bang = true }
vim.api.nvim_create_user_command('Vter', function(opts) term_cmd('vs', vim.g.magno_cmd, opts) end, attributes)
vim.api.nvim_create_user_command('Hter', function(opts) term_cmd('sp', vim.g.magno_cmd, opts) end, attributes)

-- Quickly open a Python interactive console
vim.api.nvim_create_user_command('Vpy', function(opts) term_cmd('vs', 'python3', opts) end, { nargs = 0, bang = false })
vim.api.nvim_create_user_command('Hpy', function(opts) term_cmd('sp', 'python3', opts) end, { nargs = 0, bang = false })

