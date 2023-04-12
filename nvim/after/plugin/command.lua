-- Asks for a command a runs it in a vertical split window
vim.api.nvim_set_var('magno_cmd', '')

local function term_cmd(cmd, opts)
    if (#opts.fargs ~= 0) then
      vim.g.magno_cmd = table.concat(opts.fargs, ' ')
    end

    if (opts.bang) then
      vim.fn.execute(':' .. cmd .. ' | term ')
    else
      vim.fn.execute(':' .. cmd .. ' | term ' .. vim.g.magno_cmd)
    end
end

local attributes = { nargs = '*', complete = 'shellcmd', bang = true }
vim.api.nvim_create_user_command('Vter', function(opts) term_cmd('vs', opts) end, attributes)
vim.api.nvim_create_user_command('Hter', function(opts) term_cmd('sp', opts) end, attributes)
