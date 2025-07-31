local function mini_files_config()
  local function map(mapping, mapped, opts)
    vim.keymap.set('n', mapping, mapped, opts)
  end

  ---- NEW IN EDITOR OPTIONS --------------------------------------------------

  local show_dotfiles = true
  local toggle_dotfiles = function()
    -- Show everything
    local function filter_show(_)
      return true
    end

    -- Hide dotfiles
    local function filter_hide(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end

    -- Toggle filters
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide

    -- Apply the new filter
    MiniFiles.refresh({ content = { filter = new_filter } })
  end

  -- Set focused directory as current working directory
  local set_cwd = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then
      return vim.notify('Cursor is not on valid entry')
    end
    vim.fn.chdir(vim.fs.dirname(path))
  end

  -- Yank in register full path of entry under cursor
  local yank_path = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then
      return vim.notify('Cursor is not on valid entry')
    end
    vim.fn.setreg(vim.v.register, path)
  end

  -- Open path with system default handler (useful for non-text files)
  local ui_open = function()
    vim.ui.open(MiniFiles.get_fs_entry().path)
  end

  -- Not, setup the keymaps
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf = args.data.buf_id
      map('g.', toggle_dotfiles, { buffer = buf, desc = 'Toggle dotfiles' })
      map('g~', set_cwd,         { buffer = buf, desc = 'Set CWD to current' })
      map('gX', ui_open,         { buffer = buf, desc = 'Open with OS program' })
      map('gy', yank_path,       { buffer = buf, desc = 'Yank path' })
    end,
  })

  ---- OPENING KEYMAPS --------------------------------------------------------

  map('<leader>-', function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end, { desc = 'Launch file editor' })
  map('<leader>_', function() MiniFiles.open(nil, false) end, { desc = 'Launch file editor in CWD' })
  map('<leader>.', function() MiniFiles.open() end, { desc = 'Launch file editor the previous state' })

  -- Close mini.files when opening telescope
  vim.api.nvim_create_autocmd("User", {
    pattern = "TelescopeFindPre",
    callback = function()
      local ok, mini_files = pcall(require, "mini.files")
      if ok then
        mini_files.close()
      end
    end
  })
end

return {
  {
    ---------------------------------------------------------------------------
    ---- MINI.NVIM ------------------------------------------------------------
    ---------------------------------------------------------------------------
    -- Collection of small plugins that improve the overall Neovim experience.
    -- Each lua module is a single plugin: unless loaded, will not be used.
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      ---- AI ----
      -- Enhance base textobjects and create new ones.
      --
      -- ACTIONS
      --
      --   vnaf       Selects the next function call (useful when you're inside one)
      --   vlaf       Selects the previous function call
      --   caf .      Dot repeatable
      --   vaf af af  Can repeat textobject again to move to the next one
      --              If they are nested, will extend the selection outwards
      --   v2af       Can add counts repeat the motion
      --
      -- TEXTOBJECTS
      --
      --   ([{<    Brackets, 'i' includes whitespace
      --   )]}> b  Brackets, 'i' excludes whitespace
      --   "'`  q  Quotes,   'i' includes whitespace
      --
      --   t       Tag:           <tag>content</tag>
      --   f       Function call: name(arg1, arg2)    'a' includes name, 'i' just parentheses
      --   a       Argument:      name(arg1, arg2)
      --   ?       User prompt, specify start and end char
      --   <Other> Start and end chars are the specified
      --
      require('mini.ai').setup()

      ---- SURROUNDS ----------------------------------------------------------
      --   sa<o><s>   Surround add
      --   sd<o><s>   Surround delete
      --   sr<o><s>   Surround replace
      --   sf<o><s>   Find surrounding (cursor must be inside the surrounding)
      --   sh<o><s>   Highlight surrounding chars (cursor must be inside the surrounding)
      --
      -- Where <o> is a textobject ('iw', visual mode...) and <s> is one of the
      -- next surroundings.
      --
      -- SURROUNDINGS
      --   ([{<    Braces with spaces around
      --   )]}>    Braces with no spaces
      --   f       Function call
      --   t       Tag
      --   ?       Interactive
      --   <Other> Surrounds with that char
      --
      --   b  Defaults to ), but matches to )]}>  (braces)
      --   q  Defaults to ", but matches to "'`   (quotes)
      --
      require('mini.surround').setup()

      ---- ALIGN --------------------------------------------------------------
      --   ga<textobject>   (if you wait, will be interactive)
      --   gA<textobject>   Interactive
      --
      -- Or in visual mode (note that charwise, linewise and blockwise behave
      -- differently)
      --
      -- Alignment steps:
      --
      --   <Split>   Split lines into parts
      --   <Justify> Fill each part so they have the same width
      --   <Merge>   Merge parts into lines
      --
      -- Each of these can have any preliminary steps: pre-split, pre-merge...
      --
      -- STEPS' DELIMITERS
      --
      --   s    Enter split pattern: where to divide into columns
      --   j    Enter justification: left, center, right, none
      --        Adds whitespace around the column.
      --   m    Enter merge delimiter: what to add between each column
      --
      -- The delimiters can be Lua Regex Patterns (':h lua-pattern')
      --
      -- MODIFIERS ADDING PRE-STEPS (these options can be repeated)
      --
      --   f    Lua condition to filter what parts will be affected
      --        Variables:
      --          row  Row number
      --          ROW  Total number of rows
      --          col  Column number
      --          COL  Total number of columns
      --          s    String value of the current element
      --          n    Column pair number (useful when filtering by result of splitting)
      --          N    Total number of columns pairs
      --          And all variables from the global table '_G'
      --
      --        Examples:
      --          - Align everything but the second line: row =~ 2
      --          - Align only first column: n == 1
      --
      --   i    Ignore unwanted split matches (like comments and content inside strings)
      --   p    Pair neighboring parts: joins first column with second and so on (Useful with commas).
      --   t    Trim whitespace of columns before justification
      --   <BS> Delete some last pre-step. You can switch by adding an extra
      --        step and then delete both: 'ptp<BS><BS>'.
      --
      -- Special patterns
      --
      --   =        Align consecutive group of '='
      --   ,        Split by ',' but join with the previous columns
      --   |        Split by '|' and merge with space
      --   <Space>  Split by '%s+' and merge with space
      --
      require('mini.align').setup()

      ---- BRACKETED ----------------------------------------------------------
      -- Supports specifying a count. Those which stay in the same buffer are
      -- also mapped in visual and operator-pending mode with dot-repeat.
      --
      -- Being 'x' one of the actions below, the meaning of the mappings are:
      --
      --   [x   Go next
      --   ]x   Go previous
      --   [X   Go first
      --   ]X   Go last
      --
      -- ACTIONS
      --
      --   b    Buffer         ('[b' ']b' are already defaults)
      --   w    Windows in the current tab
      --   x    Conflict marker (git)
      --   o    Old files
      --   f    File on disk
      --   c    Comment block
      --   i    Indent change
      --   d    Diagnostic     ('[d' ']d' are already defaults)
      --   l    Items in the location list
      --   q    Items in the quickfix window
      --   t    Tree-sitter node and parents
      --   u    Undo states
      --   j    Jumps from jumplist (:h jumplist)
      --   y    Yank selection
      require('mini.bracketed').setup()

      ---- FILES --------------------------------------------------------------
      -- NAVIGATION
      --   q   Close
      --   l   Open file/directory
      --   L   Open file/directory and closes de explorer
      --   h   Focus on the parent directory
      --   H   Same as before with and closes the right window
      --   =   Synchronize changes with disk
      --   < > Close left/right windows
      --   m   Create bookmark
      --   '   Jump to bookmark
      --   g?  Show help
      require('mini.files').setup()
      mini_files_config()

      ---- STATUS LINE --------------------------------------------------------
      require('mini.statusline').setup {
        use_icons = true,
        content = {
          -- TODO: change inactive colors to highlight windows better
          inactive = nil, -- Inactive windows, use defaults (just the filename)
          active = function()
            -- Vim mode: Normal, Insert, Visual, Command, Terminal
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })

            -- Search results
            local search = MiniStatusline.section_searchcount({ trunc_width = 75 })
            if search and search ~= '' then
              search = '[Search: ' .. search .. ']'
            end

            -- Number of LSPs attached as a '+' char and the number of errors
            -- (E), warnings (W), information (I), hints (H)
            local lsp = MiniStatusline.section_lsp({
              trunc_width = 75,
              ERROR = 'E',
              WARN = 'W',
              INFO = 'I',
              HINT = 'H',
            })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })

            -- Filename and '[+]' if it is not saved
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })

            -- Git branch name and diff status
            local git = MiniStatusline.section_git({ trunc_width = 40 })
            if git and git ~= '' then
              git = git .. ' |'
            end

            local diff = MiniStatusline.section_diff({ trunc_width = 75 })
            if diff and diff ~= '' then
              diff = diff .. ' |'
            end

            -- Filetype fileencoding[fileformat] buffer-size
            local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
            fileinfo = string.gsub(fileinfo, "(%S+)%s+(%S+)%s+(%S+)", "%1 | %2 | %3")

            -- Line and column inside of the file. Always use the short form.
            local location = MiniStatusline.section_location({ trunc_width = math.huge })

            return MiniStatusline.combine_groups({
              { hl = mode_hl,                  strings = { mode, search } },
              { hl = 'MiniStatuslineDevinfo',  strings = { lsp, diagnostics } },
              '%<', -- Mark general truncate point
              { hl = 'MiniStatuslineFilename', strings = { filename } },
              '%=', -- End left alignment
              { hl = 'MiniStatuslineFileinfo', strings = { git, diff, fileinfo } },
              { hl = mode_hl,                  strings = { location } },
            })
          end,
        },
      }
    end
  } -- mini
} -- return
