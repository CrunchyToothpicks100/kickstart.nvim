local builtin = require 'telescope.builtin'

-- Basic
vim.keymap.set('n', '<Space>j', '<C-e>', { desc = 'Scroll Down' })
vim.keymap.set('n', '<S-k>', '<C-y>', { desc = 'Scroll Up' })

-- Reload
vim.keymap.set('n', '<A-s>', function ()
    local root = '~/.config/nvim/'
    local source_files = {'init.lua', 'lua/oliver/keymaps.lua', 'lua/oliver/options.lua'}
    for _, value in ipairs(source_files) do
        vim.cmd("source " .. root .. value)
    end
end, { desc = 'Reload source files' })

-- Window
vim.keymap.set('n', '<F3>', '<Cmd>sp ~/.config/nvim/lua/oliver/keymaps.lua<CR>', { desc = 'Keymap Split' })
vim.keymap.set('n', '<F2>', '<Cmd>vert sp ~/.config/nvim/lua/oliver/keymaps.lua<CR>', { desc = 'Vertical Keymap Split' })
vim.keymap.set('n', '<A-i>', '<Cmd>10split | term<CR><S-a>', { desc = 'CL[I]'})
vim.keymap.set('t', '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<A-q>', '<C-\\><C-n><Cmd>bd!<CR>')

-- Colorscheme
vim.keymap.set('n', '<leader>c', function() builtin.colorscheme {} end, { desc = '[C]olor Scheme' })
vim.keymap.set('n', '<Leader>b', function()
    if vim.o.background == "dark" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end
end, { desc = "Toggle dark/light [B]ackground" })

-- S-tier: tokyonight-night, tokyonight-storm, tokyonight, catppuccin, habamax, miniwinter (dark), miniautumn (dark)
-- A-tier: minischeme (dark), minisummer (light), minispring (light), minicyan (light), miniautumn (light), sorbet, unokai, zaibatsu
-- B-tier: wildcharm, quiet (dark), quiet (light), desert, slate, retrobox (dark), retrobox (light), minisummer (dark), miniautumn (dark), minicyan (dark)
-- C-tier: peachpuff, shine, lunaperche (light), minischeme (light), lunaperche (dark), darkblue, evening, morning
-- D-tier: murphy, blue, ron, torte, vim, industry, delek, zellner
-- F-tier: koehler, pablo, elflord

-- Insert mode
vim.keymap.set('i', 'jk', '<Esc>')

print("Hello from keymaps.lua!")
