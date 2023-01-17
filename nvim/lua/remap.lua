-- Modes
--   n    Normal
--   i    Insert
--   c    Command
--   v    Visual and Select
--   x    Visual
--   s    Select
--   t    Terminal (insert mode inside of a terminal)
local map = vim.keymap.set
vim.g.mapleader = ' '

---- Misc ----
map({'n', 'v'}, '+', '$')
map({'n', 'v'}, '-', '^')

map('i', '<C-H>', '<C-w>')    -- Delete word in Insert mode
map('n', 'U',     '<C-R>')    -- Redo with U

-- Stay in visual mode after identing
map('v', '<', '<gv')
map('v', '>', '>gv')

map({'n', 'x'}, "'", '`')

-- NOTE: I use a EU keyboard, not US.
map({'n', 'v'}, ';', ',')     -- Repeat f, F, t, T backwards
map({'n', 'v'}, ',', ';')     -- Repeat f, F, t, T

-- Yank and Paste
map('v', '<Leader>p', '"_dP')
map('n', '<Leader>Y', '"+Y')
map({'n', 'v'}, '<Leader>y', '"+y')   -- Yank to system clipboard
map({'n', 'v'}, '<Leader>d', '"_d')

---- Commands ----
-- Refactor symbol (reName)
map('n', '<Leader>n', ':%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>')
map('n', '<Leader>x', vim.cmd.bdel)
map('n', '<Leader>w', vim.cmd.write)

-- TODO: Not working
-- Move text
--map('n', '<A-j>', function() vim.cmd.move('+1') end)
--map('n', '<A-k>', function() vim.cmd.move('-2') end)
--map('v', 'J', "<CMD>move '>+1<Enter>gv=gv")
--map('v', 'K', "<CMD>move '<-2<Enter>gv=gv")

-- Scroll
map({'n', 'v'}, '<C-k>', '<C-y>') -- Scroll
map({'n', 'v'}, '<C-j>', '<C-e>')

---- Centering cursor ----
map({'n', 'v'}, 'n', 'nzz')
map({'n', 'v'}, 'N', 'Nzz')

map({'n', 'v'}, '<C-b>', '<C-b>zz')
map({'n', 'v'}, '<C-f>', '<C-f>zz')
map({'n', 'v'}, '<C-d>', '<C-d>zz')
map({'n', 'v'}, '<C-u>', '<C-u>zz')

---- Windows & Buffers & Tabs ----
map({'n', 'v'}, 'ñ', '<C-w>')
map({'n', 'v'}, 'Ñ', '<C-w>')
map('n', '<C-Right>', vim.cmd.tabn) -- Move between tabs
map('n', '<C-Left>',  vim.cmd.tabp)

---- Exiting ----
map('t', '<Esc>', '<C-\\><C-N>')    -- Exit terminal
map('t', 'jk',    '<C-\\><C-N>')
map('t', 'kj',    '<C-\\><C-N>')
map('i', 'jk',    '<Esc>')          -- Exit insert mode
map('i', 'kj',    '<Esc>')

---- My custom mappings ----
-- Asks for a command a runs it in a vertical split window
magno_cmd = ''
map('n', '<Leader>c', function()
    vim.ui.input({
        prompt = 'Command > ',
        default = nil,
        completion = 'file'
    },
    function(input)
        if (not (input == nil or input == '')) then
            magno_cmd = input
            vim.fn.execute(':vs term://' .. magno_cmd)
        end
    end)
end)

-- Repeats last command
map('n', '<Leader>C', function()
    if (not (input == nil or input == '')) then
        vim.fn.execute(':vs term://' .. magno_cmd)
    end
end)

vim.api.nvim_create_autocmd({'TermOpen'}, {
    callback = function() map('n', '<Enter>', 'i<Enter>', { buffer=true }) end
})
