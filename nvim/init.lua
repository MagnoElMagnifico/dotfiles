--
-- NEW RULES:
--   - Use defaults whenever possible, specially for keymaps. Some options may
--     be set explicitly in case they're important or planned to be changed in
--     the future.
--   - No need to list every possible configuration, just change what it needs
--     to be changed
--   - Not every command must be mapped to a key, only what I use the most
--

---- OPTIONS ----
-- TODO: not sure about this
vim.o.completeopt = 'fuzzy,menu,menuone,noinsert,popup'
vim.o.selection = 'exclusive' -- Show the selection exactly
vim.opt.iskeyword:append('-') -- Treat '-' as part of a word

-- TODO: folds
-- vim.o.foldmethod     = 'indent'
-- vim.o.foldenable     = true
-- vim.o.foldlevelstart = 5
-- vim.o.foldnestmax    = 5

-- Scroll margins
vim.o.scrolloff     = 10
vim.o.sidescrolloff = 10

-- Show relative line numbers
vim.o.number         = true
vim.o.relativenumber = true

-- Wrap
vim.o.wrap        = true -- Wrap long lines to fit the screen
vim.o.breakindent = true -- Wrapped lines must follow indentation
vim.o.showbreak   = '\\' -- Show this char when a line is wrapped

-- Search
vim.opt.path:append('**')    -- Search in all subdirectories as well
vim.o.smartcase  = true      -- Search case insensitive, unless searching uppercase
vim.o.ignorecase = true      -- Required for 'smartcase' to work
vim.o.incsearch  = true      -- Show matches while typing
vim.o.hlsearch   = true      -- Highlight matches
vim.o.inccommand = 'nosplit' -- Show substitutions live in the window

-- Visuals
vim.o.termguicolors = true -- Use 24 bit colors in the terminal
vim.o.lazyredraw    = true -- Don't update screen while executing macros
vim.o.colorcolumn   = '80' -- Show ruler at column 80
vim.o.cursorline    = true -- Show current line
vim.o.list          = true -- Show whitespaces
vim.opt.listchars = {
	tab   = '> ', -- Tabs rendered as '>' when they start
	trail = '·',  -- Trailing spaces
	nbsp  = '␣',  -- Non breaking spaces
}

-- Format
vim.o.autoindent = true  -- Keep same indentation on the next line
vim.o.smartindent = true -- C-like indenting

vim.o.shiftwidth = 4     -- Amount of spaces for indentation
vim.o.expandtab  = false -- '<Tab>' insert tabs, not spaces
vim.o.tabstop    = 4     -- Make tabs render and behave like 4 spaces

vim.o.textwidth   = 80   -- Maximum length of the text
-- t  Autowrap on textwidth
-- c  Wrap comments
-- r  Inside comments, '<Enter>' inserts a new comment
-- o  Same as before, but with 'o' command
-- /  When 'o', don't insert comment if it's not the whole line
-- q  Formatting comments
-- a  Automatic formatting for paragraphs
-- n  Recognize numbered lists
-- l  Don't format longer lines
-- j  Remove comment leader when joining lines
vim.o.formatoptions = 'tcro/qnlj'
-- Include unnumbered lists (with '*' may not work that well)
vim.o.formatlistpat = [[^\s*\(\d\+[\.)]\|[-+*]\)\s\+]]

-- Key behaviour
vim.o.mouse = 'a'                           -- Use mouse in command mode as well
vim.o.backspace = 'indent,eol,start,nostop' -- No limitations to backspace

-- Files
vim.o.fileencoding = 'UTF-8' -- Use UTF-8 always
vim.o.spelllang    = 'es,en' -- Vocabulary check in Spanish and English

vim.o.undofile  = true  -- Keep undo history even after restart
vim.o.autoread  = true  -- Update buffer if file changed on disk
vim.o.autowrite = false -- Don't write to disk automatically
vim.o.hidden    = true  -- Keep buffers loaded even if no window is showing them

-- Window opening
vim.o.splitbelow = true
vim.o.splitright = true

