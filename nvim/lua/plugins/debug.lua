-- -- Maybe even better than DAP:
-- vim.cmd.packadd('termdebug')
-- vim.g.termdebug_wide = 80
--
-- local map = vim.keymap.set
--
-- map('n', '<Leader>db', vim.cmd.Break)    -- Add breakpoint
-- map('n', '<Leader>dB', vim.cmd.Clear)    -- Remove breakpoint
-- map('n', '<Leader>n',  vim.cmd.Step)     -- Advance to next line
-- map('n', '<Leader>o',  vim.cmd.Over)     -- Advance to the next line without entering functions
-- map('n', '<Leader>du', vim.cmd.Until)    -- Run until cursor
-- map('n', '<Leader>dc', vim.cmd.Continue) -- Continue until next breakpoint
-- map('n', '<Leader>df', vim.cmd.Finish)   -- Continue until the end of the function

return {
  'mfussenegger/nvim-dap',

  dependencies = {
    -- Creates a debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Virtual text for variables values
    {'theHamsta/nvim-dap-virtual-text', opts = {}},

    -- Installs the debug adapters for me
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },

  config = function()
    local dap = require 'dap'
    local dap_ui = require 'dapui'
    local dap_widgets = require 'dap.ui.widgets'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- Ensure to install these debuggers
      ensure_installed = {
        'codelldb',
      },

      -- Additional configuration to the handlers
      handlers = {
        ---- Default handler configuration ----
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,

        ---- C / C++ / Rust ----
        codelldb = function(config)
          -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
          -- https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
          config.adapters = {
            type = 'server',
            port = '${port}',
            executable = {
              command = vim.fn.stdpath('data') .. '/mason/bin/codelldb',
              args = {'--port', '${port}'},
            },
          }

          config.configurations.cpp = {
            {
              name = 'Debug program',
              type = 'codelldb',
              request = 'launch',
              program = function()
                return vim.fn.input('Path to executable')
              end,
              cwd = '${workspaceFolder}',
              stopOnEntry = false,
            }
          }

          config.configurations.c = config.configurations.cpp
          config.configurations.rust = config.configurations.cpp

          require('mason-nvim-dap').default_setup(config)
        end,
      },
    }

    -- Add more information to :DapShowLog
    dap.set_log_level('INFO')

    ---------------------------------------------------------------------
    ---- Keymaps --------------------------------------------------------
    ---------------------------------------------------------------------
    local function nmap(keys, func, desc)
      vim.keymap.set('n', keys, func, { desc = 'Debug: ' .. desc })
    end

    local function nvmap(keys, func, desc)
      vim.keymap.set({'n', 'v'}, keys, func, { desc = 'Debug: ' .. desc })
    end

    -- Start / Continue / Finish / Terminate
    nmap('<F9>', dap.continue, 'Start/Continue')
    nmap('<F10>', dap.terminate, 'Finish debugging')

    -- Toggle to see last session result. Without this, you can't see session
    -- output in case of unhandled exception.
    nmap('<F11>', dap_ui.toggle, 'Toggle UI')

    -- Stepping
    nmap('<F1>', dap.step_into, 'Step Into function call')
    nmap('<F2>', dap.step_over, 'Step Over to next sentence')
    nmap('<F3>', dap.step_out, 'Step Out of function')
    nmap('<F4>', dap.run_to_cursor, 'Run to cursor')

    nmap('<F5>', dap.step_back, 'Step Back (Step Into Reversed)')
    nmap('<F6>', dap.reverse_continue, 'Reverse Continue until breakpoint')

    -- Breakpoints
    nmap('<Leader>b', dap.toggle_breakpoint, 'Toggle [B]reakpoint')
    nmap('<Leader>B', function() dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, 'Set conditional [B]reakpoint')
    nmap('<Leader>dl', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, 'Set [L]og point')

    nmap('<Leader>db', dap.list_breakpoints, 'List breakpoints in a quick fix window')
    nmap('<Leader>dB', dap.clear_breakpoints, 'Remove all breakpoints')

    -- Info
    nvmap('<Leader>dh', dap_widgets.hover, '[H]over expression')
    nmap('<Leader>dj', dap.focus_frame, '[J]ump to current frame')

    -- Already in the UI
    -- nmap('<Leader>df', function() dap_widgets.centered_float(dap_widgets.frames) end, 'Show call [F]rames')
    -- nmap('<Leader>ds', function() dap_widgets.centered_float(dap_widgets.scopes) end, 'Show [S]copes')

    -- Console
    nmap('<Leader>dc', dap.repl.open, 'Open interactive [c]onsole')
    -- TODO: Add custom commmands (?)
    -- TODO: Set CLI arguments

    ---------------------------------------------------------------------
    ---- DAP UI Setup ---------------------------------------------------
    ---------------------------------------------------------------------
    -- For more information, see |:help nvim-dap-ui|
    dap_ui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dap_ui.open
    dap.listeners.before.event_terminated['dapui_config'] = dap_ui.close
    dap.listeners.before.event_exited['dapui_config'] = dap_ui.close
  end,

  -- keys = {
  --   -- For codelldb: source a launch.json and resume sessions
  --   {
  --     '<F5>',
  --     function()
  --       -- (Re-)reads launch.json if present
  --       if vim.fn.filereadable('.vscode/launch.json') then
  --         require('dap.ext.vscode').load_launchjs(nil, {
  --           ['codelldb'] = { 'c', 'cpp' },
  --         })
  --       end
  --       require('dap').continue()
  --     end,
  --     desc = 'DAP Continue',
  --   },
  -- },
}
