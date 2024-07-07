-- Asks for a command and runs it in a vertical split window
vim.api.nvim_set_var('magno_cmd', '')

local function term_cmd(split, opts)
    if (#opts.fargs ~= 0) then
      vim.api.nvim_set_var('magno_cmd', table.concat(opts.fargs, ' '))
    end

    if (opts.bang) then
      vim.fn.execute(':' .. split .. ' | term ')
    else
      vim.fn.execute(':' .. split .. ' | term ' .. vim.g.magno_cmd)
    end
end

vim.api.nvim_create_user_command('Vterm', function(opts) term_cmd('vs', opts) end, { nargs = '*', bang = true })
vim.api.nvim_create_user_command('Hterm', function(opts) term_cmd('sp', opts) end, { nargs = '*', bang = true })

-- Quickly open a Python interactive console
vim.api.nvim_create_user_command('Vpy', ':vs | term python3', { nargs = 0, bang = false })
vim.api.nvim_create_user_command('Hpy', ':sp | term python3', { nargs = 0, bang = false })

