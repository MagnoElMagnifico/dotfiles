-- Command history (didn't work as a vim global variable)
Cmd_history = {}

local function run_cmd(split, opts)
  if #opts.fargs ~= 0 and Cmd_history[#Cmd_history] ~= opts.args then
    table.insert(Cmd_history, opts.args)
  end

  if opts.bang or #Cmd_history == 0 then
    vim.fn.execute(':' .. split .. ' | term')
  else
    vim.fn.execute(':' .. split .. ' | term ' .. Cmd_history[#Cmd_history])
  end
end

local function cmd_picker()
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  pickers.new({}, {
    prompt_title = "Previous commands",
    finder = finders.new_table { results = Cmd_history },
    sorter = conf.generic_sorter(),
    attach_mappings = function(prompt, map)
      actions.select_default:replace(function()
        actions.close(prompt)
        local selection = action_state.get_selected_entry()
        vim.fn.execute(':Vcmd ' .. selection[1])
      end)
      return true
    end
  }):find()
end

-- Open terminal or run command on the side
vim.api.nvim_create_user_command('Vcmd', function(opts) run_cmd('vs', opts) end, { nargs = '*', bang = true })
vim.api.nvim_create_user_command('Hcmd', function(opts) run_cmd('sp', opts) end, { nargs = '*', bang = true })

-- Pick between previously executed commands
vim.api.nvim_create_user_command('Cmd', cmd_picker, { nargs = '*', bang = true })

-- Quickly open a Python interactive console
vim.api.nvim_create_user_command('Vpy', ':vs | term python3', { nargs = 0, bang = false })
vim.api.nvim_create_user_command('Hpy', ':sp | term python3', { nargs = 0, bang = false })

-- Find files in a specific directory with telescope
vim.api.nvim_create_user_command('FF', function(opts)
  require('telescope.builtin').find_files({ cwd = opts.args })
end, { nargs = 1, bang = true, complete = 'dir' })

-- Grep files in a specific directory with telescope
vim.api.nvim_create_user_command('GF', function(opts)
  require('telescope.builtin').live_grep({ cwd = opts.args, max_results = 1000 })
end, { nargs = 1, bang = true, complete = 'dir' })

