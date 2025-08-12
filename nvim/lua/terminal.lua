return {
  -- TEST: toggleterm.nvim plugin
  -- COMMANDS
  --   ToggleTerm  Toggles a terminal
  --     <count>   Selects a terminal to use
  --     size      Height/width, depending on the direction
  --     dir       Set CWD for the terminal, otherwise uses Neovim's CWD
  --     direction vertical, horizontal, float, tab
  --     name      Display name when selecting
  --
  --   TermExec    Open terminal with an action
  --     <count>   Selects a terminal to use
  --     cmd       Quoted command to run
  --     dir       CWD for the command
  --     open=0    Run in the background
  --     go_back=0 Keep focus on the terminal window
  --     ...       Other arguments of ToggleTerm
  --
  --   TermNew     Opens a new terminal at the avaliable <count>
  --   TermSelect  Selects a terminal to open or focus
  --   ToggleTermSetName Changes display name
  --
  --   ToggleTermSendCurrentLine [terminalID]
  --   ToggleTermSendVisualLines [terminalID]
  --   ToggleTermSendVisualSelection [terminalID]
  --
  -- These options can use vim's expands (':h expand').
  -- Using multiple terminals is unsupported, in that case use a multiplexer.
  {
    'akinsho/toggleterm.nvim',
    keys = { { '<C-,>', mode = { 'n', 'v', 't', 'i' } } },

    -- I don't know the defaults
    opts = {
      open_mapping = '<C-,>', -- can be an array
      insert_mappings = true,
      terminal_mappings = true,

      hide_numbers = true,
      autochdir = false,
      start_in_insert = true,
      direction = 'float', -- maybe vertical

      persist_mode = true,
      persist_size = true,
      close_on_exit = true,
    }
  }
} -- return
