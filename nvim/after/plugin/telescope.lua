local nmap = function (mapping, mapped, desc) vim.keymap.set('n', mapping, mapped, { desc = desc }) end
local tl = require('telescope.builtin')

-- More info:
-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim#pickers

-- Files
nmap('<Leader>g',  tl.git_files,   'Telescope [G]it files')
nmap('<Leader>a',  tl.find_files,  'Telescope Find [F]iles')
nmap('<Leader>ss', tl.live_grep,   'Telescope [S]earch files')
nmap('<Leader>sw', tl.grep_string, 'Telescope [S]earch [W]ord under cursor')
nmap('<Leader>/',  tl.current_buffer_fuzzy_find, 'Telescope search buffer (/)')

-- Vim
nmap('<Leader>r', tl.registers, 'Telescope [R]egisters')
nmap('<Leader>b', tl.buffers,   'Telescope [B]uffers')
nmap('<Leader>m', tl.marks,     'Telescope [M]arks')

nmap('<Leader>tt', tl.builtin,       '[T]elescope pickers')
nmap('<Leader>to', tl.oldfiles,      'Telescope [O]ld files')
nmap('<Leader>ts', tl.spell_suggest, '[T]elescope [S]pell suggest under cursor')
nmap('<Leader>tm', tl.man_pages,     '[T]elescope [M]anpages')
nmap('<Leader>th', tl.help_tags,     '[T]elescope [H]elp tags')

-- Git
nmap('<Leader>tgs', tl.git_status,   '[T]elescope [G]it [S]tatus')
nmap('<Leader>tgc', tl.git_bcommits, '[T]elescope [G]it [C]ommits')
nmap('<Leader>tgb', tl.git_branches, '[T]elescope [G]it [B]ranches')

-- NOTE: Telescope's LSP config is in lsp.lua
