return {
  'mfussenegger/nvim-dap',

  lazy = true,
  -- TODO: load on commands?

  keys = {
    -- TODO: Add custom commmands (?)
    -- TODO: Set CLI arguments

    { '<Leader>dc', function() require('dap').repl.open() end, desc = 'Debug: Open interactive console' },

    -- Start / Continue / Finish / Terminate
    { '<F9>', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
    { '<F10>', function() require('dap').terminate() end, desc = 'Debug: Finish debugging' },

    -- Toggle to see last session result. Without this, you can't see session
    -- output in case of unhandled exception.
    { '<F11>', function() require('dapui').toggle() end, desc = 'Debug: Toggle UI' },

    -- Stepping
    { '<F1>', function() require('dap').step_into() end, desc = 'Debug: Step Into function call' },
    { '<F2>', function() require('dap').step_over() end, desc = 'Debug: Step Over to next sentence' },
    { '<F3>', function() require('dap').step_out() end, desc = 'Debug: Step Out of function' },
    { '<F4>', function() require('dap').run_to_cursor() end, desc = 'Debug: Run to cursor' },

    { '<F5>', function() require('dap').step_back() end, desc = 'Debug: Step Back (Step Into Reversed)' },
    { '<F6>', function() require('dap').reverse_continue() end, desc = 'Debug: Reverse Continue until breakpoint' },

    -- Breakpoints
    { '<Leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<Leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set conditional Breakpoint' },
    { '<Leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = 'Debug: Set Log point' },

    { '<Leader>dq', function() require('dap').list_breakpoints() end, desc = 'Debug: List breakpoints in a quick fix window' },
    { '<Leader>dd', function() require('dap').clear_breakpoints() end, desc = 'Debug: Remove all breakpoints' },

    -- Info
    { '<Leader>dh', function() require('dap.ui.widgets').hover() end, desc = 'Debug: Hover expression', mode = { 'n', 'v' } },
    { '<Leader>dj', function() require('dap').focus_frame() end, desc = 'Debug: Jump to current frame' },
  },

  dependencies = {
    -- Virtual text for variables values
    {'theHamsta/nvim-dap-virtual-text', opts = {}},

    -- Installs the debug adapters for me
    'williamboman/mason.nvim',

    {
      'jay-babu/mason-nvim-dap.nvim',
      opts = {
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
        }, -- handlers
      }, -- opts
    }, -- mason-nvim-dap

    -- Creates a debugger UI
    {
      'rcarriga/nvim-dap-ui',
      dependencies = { 'nvim-neotest/nvim-nio' },
      opts = {
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
      }, -- opts
    }, -- dapui
  }, -- dependencies

  config = function()
    local dap = require 'dap'
    local dap_ui = require 'dapui'
    dap.listeners.after.event_initialized['dapui_config'] = dap_ui.open
    dap.listeners.before.event_terminated['dapui_config'] = dap_ui.close
    dap.listeners.before.event_exited['dapui_config'] = dap_ui.close
  end,
}
