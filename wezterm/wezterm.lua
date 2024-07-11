local wezterm = require 'wezterm'
local act = wezterm.action;

local config = {}

-- Looks
-- Fonts:
--   - FiraCode Nerd Font      10
--   - Hurmit Nerd Font        10
--   - CaskaydiaCove Nerd Font 11
--   - Mononoki Nerd Font      11
--   - Monofur Nerd Font       12.5
config.font = wezterm.font('FiraCode Nerd Font', { weight = 'Medium' })
config.font_size = 10

config.color_scheme = 'Breeze'
config.audible_bell = 'Disabled'

config.enable_scroll_bar = false
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- TODO: background

-- Initial sizes
config.initial_cols = 150
config.initial_rows = 40
config.scrollback_lines = 3500

-- GPU usage
config.front_end = 'WebGpu'
config.webgpu_power_preference = 'LowPower' -- Extend battery life

-- Other
config.adjust_window_size_when_changing_font_size = false
config.switch_to_last_active_tab_when_closing_tab = true

---------------------------------------------------------
---- Keymaps --------------------------------------------
---------------------------------------------------------
config.disable_default_key_bindings = true

config.keys = {
  ---------------------------------------------------------
  ---- Tabs -----------------------------------------------
  ---------------------------------------------------------
  { mods = 'ALT', key = 't', action = act.SpawnTab 'CurrentPaneDomain'  },
  { mods = 'ALT', key = 'w', action = act.CloseCurrentTab { confirm = true } },

  -- Switch tabs
  { mods = 'ALT', key = ']', action = act.ActivateTabRelative(1) },
  { mods = 'ALT', key = '[', action = act.ActivateTabRelative(-1) },
  { mods = 'ALT', key = '.', action = act.ActivateLastTab },

  { mods = 'ALT', key = '1', action = act.ActivateTab(0) },
  { mods = 'ALT', key = '2', action = act.ActivateTab(1) },
  { mods = 'ALT', key = '3', action = act.ActivateTab(2) },
  { mods = 'ALT', key = '4', action = act.ActivateTab(3) },
  { mods = 'ALT', key = '5', action = act.ActivateTab(4) },
  { mods = 'ALT', key = '6', action = act.ActivateTab(5) },
  { mods = 'ALT', key = '7', action = act.ActivateTab(6) },
  { mods = 'ALT', key = '8', action = act.ActivateTab(7) },
  { mods = 'ALT', key = '9', action = act.ActivateTab(8) },

  -- Move tabs
  { mods = 'ALT',       key = '}', action = act.MoveTabRelative(1) }, -- US keywoard
  { mods = 'ALT',       key = '{', action = act.MoveTabRelative(-1) },
  { mods = 'ALT|SHIFT', key = '}', action = act.MoveTabRelative(1) }, -- EU keyboard
  { mods = 'ALT|SHIFT', key = '{', action = act.MoveTabRelative(-1) },

  ---------------------------------------------------------
  ---- Panes ----------------------------------------------
  ---------------------------------------------------------
  { mods = 'ALT', key = 'v', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' }},
  { mods = 'ALT', key = 'b', action = act.SplitVertical   { domain = 'CurrentPaneDomain' }},

  -- Zoom mode
  { mods = 'ALT', key = 'Enter', action = act.TogglePaneZoomState },
  { mods = 'ALT', key = 'z',     action = act.TogglePaneZoomState },

  -- Close pane
  { mods = 'ALT', key = 'x', action = act.CloseCurrentPane { confirm = true } },

  -- Switch Panes
  { mods = 'ALT', key = 's', action = act.PaneSelect { mode = 'Activate', alphabet = '123456789' } },

  { mods = 'ALT', key = 'k', action = act.ActivatePaneDirection 'Up' },
  { mods = 'ALT', key = 'j', action = act.ActivatePaneDirection 'Down' },
  { mods = 'ALT', key = 'h', action = act.ActivatePaneDirection 'Left' },
  { mods = 'ALT', key = 'l', action = act.ActivatePaneDirection 'Right' },

  { mods = 'ALT', key = 'UpArrow',    action = act.ActivatePaneDirection 'Up' },
  { mods = 'ALT', key = 'DownArrow',  action = act.ActivatePaneDirection 'Down' },
  { mods = 'ALT', key = 'LeftArrow',  action = act.ActivatePaneDirection 'Left' },
  { mods = 'ALT', key = 'RightArrow', action = act.ActivatePaneDirection 'Right' },

  -- Move panes
  { mods = 'ALT', key = 'm', action = act.RotatePanes 'Clockwise' },
  { mods = 'ALT', key = 'S', action = act.PaneSelect { mode = 'SwapWithActive', alphabet = '123456789' } },
  { mods = 'ALT', key = 'T', action = act.PaneSelect { mode = 'MoveToNewTab', alphabet = '123456789' } },
  -- TODO: move to existing tab

  -- Resize mode
  { mods = 'ALT', key = 'r', action = act.ActivateKeyTable {
    name = 'resize_mode',
    one_shot = false,
    replace_current = true,
    until_unknown = true,
  }},

  ---------------------------------------------------------
  ---- Other ----------------------------------------------
  ---------------------------------------------------------
  -- Scroll
  { mods = 'CTRL',  key = 'PageUp',   action = act.ScrollByPage(-1) },
  { mods = 'CTRL',  key = 'PageDown', action = act.ScrollByPage(1) },
  { mods = 'SHIFT', key = 'PageUp',   action = act.ScrollByLine(-1) },
  { mods = 'SHIFT', key = 'PageDown', action = act.ScrollByLine(1) },

  -- Search mode
  { mods = 'ALT', key = 'f', action = act.Search 'CurrentSelectionOrEmptyString' },

  -- TODO: Quick select mode
  -- { mods = 'ALT', key = 'a', action = act.QuickSelect },

  -- Copy & Paste
  { mods = 'CTRL|SHIFT', key = 'c', action = act.CopyTo 'Clipboard' },
  { mods = 'CTRL|SHIFT', key = 'v', action = act.PasteFrom 'Clipboard' },

  -- Copy mode
  { mods = 'ALT', key = 'c', action = act.ActivateCopyMode },

  -- Modal Palette
  { mods = 'ALT', key = 'p', action = act.ActivateCommandPalette },

  -- TODO?: Launcher Menu
  -- { mods = 'ALT', key = '???', action = act.ShowLauncherArgs { flags = 'FUZZY|TABS' } },

  -- TODO?: Is this useful?
  { mods = 'ALT', key = 'a', action = act.CharSelect { copy_on_select = false }},

  -- Debug overlay
  { mods = 'ALT', key = 'd', action = act.ShowDebugOverlay },

  -- Clear scroll back
  { mods = 'ALT|SHIFT', key = 'L', action = act.ClearScrollback 'ScrollbackAndViewport'},

  -- Reload this config
  { mods = 'ALT|SHIFT', key = 'R', action = act.ReloadConfiguration },

  -- Quickly launch python
  { mods = 'ALT|SHIFT', key = 'P', action = act.SplitPane {
      direction = 'Right',
      size = { Cells = 40 },
      command = { label = 'Run Python', args = { 'python3', '-q' } },
      top_level = true,
    }
  },

  -- Font
  { mods = 'CTRL', key = '+', action = act.IncreaseFontSize },
  { mods = 'CTRL', key = '-', action = act.DecreaseFontSize },
  { mods = 'CTRL', key = '0', action = act.ResetFontSize },
}

config.key_tables = {
  ---------------------------------------------------------
  ---- Search mode ----------------------------------------
  ---------------------------------------------------------
  search_mode = {
    { mods = 'CTRL', key = 'r', action = act.CopyMode 'CycleMatchType' },
    { mods = 'CTRL', key = 'u', action = act.CopyMode 'ClearPattern' },

    -- Search previous
    { mods = 'NONE', key = 'Enter',   action = act.CopyMode 'PriorMatch' },
    { mods = 'CTRL', key = 'p',       action = act.CopyMode 'PriorMatch' },
    { mods = 'NONE', key = 'UpArrow', action = act.CopyMode 'PriorMatch' },
    { mods = 'NONE', key = 'PageUp',  action = act.CopyMode 'PriorMatchPage' },

    -- Search next
    { mods = 'CTRL', key = 'n',         action = act.CopyMode 'NextMatch' },
    { mods = 'NONE', key = 'DownArrow', action = act.CopyMode 'NextMatch' },
    { mods = 'NONE', key = 'PageDown',  action = act.CopyMode 'NextMatchPage' },

    -- Quit
    { mods = 'NONE', key = 'Escape', action = act.CopyMode 'Close' },
    { mods = 'CTRL', key = 'c',      action = act.CopyMode 'Close' },
  },

  ---------------------------------------------------------
  ---- Resize mode ----------------------------------------
  ---------------------------------------------------------
  resize_mode = {
    -- Resize easily with the Vim keys
    { mods = 'NONE', key = 'h', action = act.AdjustPaneSize { 'Left',  10 } },
    { mods = 'NONE', key = 'l', action = act.AdjustPaneSize { 'Right', 10 } },
    { mods = 'NONE', key = 'j', action = act.AdjustPaneSize { 'Down',  10 } },
    { mods = 'NONE', key = 'j', action = act.AdjustPaneSize { 'Up',    10 } },

    -- The arrows allow for greater control (rarely used)
    { mods = 'NONE', key = 'LeftArrow',  action = act.AdjustPaneSize { 'Left',  1 } },
    { mods = 'NONE', key = 'RightArrow', action = act.AdjustPaneSize { 'Right', 1 } },
    { mods = 'NONE', key = 'DownArrow',  action = act.AdjustPaneSize { 'Down',  1 } },
    { mods = 'NONE', key = 'UpArrow',    action = act.AdjustPaneSize { 'Up',    1 } },

    -- Quit the mode
    { mods = 'NONE', key = 'Escape', action = act.PopKeyTable },
    { mods = 'NONE', key = 'Enter',  action = act.PopKeyTable },
  },

  ---------------------------------------------------------
  ---- Copy mode ------------------------------------------
  ---------------------------------------------------------
  -- Dump defaults
  copy_mode = {
    { key = 'Tab',        mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
    { key = 'Tab',        mods = 'SHIFT', action = act.CopyMode 'MoveBackwardWord' },
    { key = 'Enter',      mods = 'NONE',  action = act.CopyMode 'MoveToStartOfNextLine' },
    { key = 'Escape',     mods = 'NONE',  action = act.CopyMode 'Close' },
    { key = 'Space',      mods = 'NONE',  action = act.CopyMode { SetSelectionMode =  'Cell' } },
    { key = '$',          mods = 'NONE',  action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = '$',          mods = 'SHIFT', action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = ',',          mods = 'NONE',  action = act.CopyMode 'JumpReverse' },
    { key = '0',          mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLine' },
    { key = ';',          mods = 'NONE',  action = act.CopyMode 'JumpAgain' },
    { key = 'F',          mods = 'NONE',  action = act.CopyMode { JumpBackward = { prev_char = false } } },
    { key = 'F',          mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = false } } },
    { key = 'G',          mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackBottom' },
    { key = 'G',          mods = 'SHIFT', action = act.CopyMode 'MoveToScrollbackBottom' },
    { key = 'H',          mods = 'NONE',  action = act.CopyMode 'MoveToViewportTop' },
    { key = 'H',          mods = 'SHIFT', action = act.CopyMode 'MoveToViewportTop' },
    { key = 'L',          mods = 'NONE',  action = act.CopyMode 'MoveToViewportBottom' },
    { key = 'L',          mods = 'SHIFT', action = act.CopyMode 'MoveToViewportBottom' },
    { key = 'M',          mods = 'NONE',  action = act.CopyMode 'MoveToViewportMiddle' },
    { key = 'M',          mods = 'SHIFT', action = act.CopyMode 'MoveToViewportMiddle' },
    { key = 'O',          mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
    { key = 'O',          mods = 'SHIFT', action = act.CopyMode 'MoveToSelectionOtherEndHoriz' },
    { key = 'T',          mods = 'NONE',  action = act.CopyMode { JumpBackward = { prev_char = true } } },
    { key = 'T',          mods = 'SHIFT', action = act.CopyMode { JumpBackward = { prev_char = true } } },
    { key = 'V',          mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Line' } },
    { key = 'V',          mods = 'SHIFT', action = act.CopyMode { SetSelectionMode = 'Line' } },
    { key = '^',          mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = '^',          mods = 'SHIFT', action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = 'b',          mods = 'NONE',  action = act.CopyMode 'MoveBackwardWord' },
    { key = 'b',          mods = 'ALT',   action = act.CopyMode 'MoveBackwardWord' },
    { key = 'b',          mods = 'CTRL',  action = act.CopyMode 'PageUp' },
    { key = 'c',          mods = 'CTRL',  action = act.CopyMode 'Close' },
    { key = 'd',          mods = 'CTRL',  action = act.CopyMode { MoveByPage = (0.5) } },
    { key = 'e',          mods = 'NONE',  action = act.CopyMode 'MoveForwardWordEnd' },
    { key = 'f',          mods = 'NONE',  action = act.CopyMode { JumpForward = { prev_char = false } } },
    { key = 'f',          mods = 'ALT',   action = act.CopyMode 'MoveForwardWord' },
    { key = 'f',          mods = 'CTRL',  action = act.CopyMode 'PageDown' },
    { key = 'g',          mods = 'NONE',  action = act.CopyMode 'MoveToScrollbackTop' },
    { key = 'g',          mods = 'CTRL',  action = act.CopyMode 'Close' },
    { key = 'h',          mods = 'NONE',  action = act.CopyMode 'MoveLeft' },
    { key = 'j',          mods = 'NONE',  action = act.CopyMode 'MoveDown' },
    { key = 'k',          mods = 'NONE',  action = act.CopyMode 'MoveUp' },
    { key = 'l',          mods = 'NONE',  action = act.CopyMode 'MoveRight' },
    { key = 'm',          mods = 'ALT',   action = act.CopyMode 'MoveToStartOfLineContent' },
    { key = 'o',          mods = 'NONE',  action = act.CopyMode 'MoveToSelectionOtherEnd' },
    { key = 'q',          mods = 'NONE',  action = act.CopyMode 'Close' },
    { key = 't',          mods = 'NONE',  action = act.CopyMode { JumpForward = { prev_char = true } } },
    { key = 'u',          mods = 'CTRL',  action = act.CopyMode { MoveByPage = (-0.5) } },
    { key = 'v',          mods = 'NONE',  action = act.CopyMode { SetSelectionMode = 'Cell' } },
    { key = 'v',          mods = 'CTRL',  action = act.CopyMode { SetSelectionMode = 'Block' } },
    { key = 'w',          mods = 'NONE',  action = act.CopyMode 'MoveForwardWord' },
    { key = 'y',          mods = 'NONE',  action = act.Multiple { { CopyTo = 'ClipboardAndPrimarySelection' }, { CopyMode =  'Close' } } },
    { key = 'PageUp',     mods = 'NONE',  action = act.CopyMode 'PageUp' },
    { key = 'PageDown',   mods = 'NONE',  action = act.CopyMode 'PageDown' },
    { key = 'End',        mods = 'NONE',  action = act.CopyMode 'MoveToEndOfLineContent' },
    { key = 'Home',       mods = 'NONE',  action = act.CopyMode 'MoveToStartOfLine' },
    { key = 'LeftArrow',  mods = 'NONE',  action = act.CopyMode 'MoveLeft' },
    { key = 'LeftArrow',  mods = 'ALT',   action = act.CopyMode 'MoveBackwardWord' },
    { key = 'RightArrow', mods = 'NONE',  action = act.CopyMode 'MoveRight' },
    { key = 'RightArrow', mods = 'ALT',   action = act.CopyMode 'MoveForwardWord' },
    { key = 'UpArrow',    mods = 'NONE',  action = act.CopyMode 'MoveUp' },
    { key = 'DownArrow',  mods = 'NONE',  action = act.CopyMode 'MoveDown' },
  },
}

return config
