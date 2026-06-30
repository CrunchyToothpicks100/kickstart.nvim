local builtin = require 'telescope.builtin'

-- ':W' will show a full list of keymaps

-- Basic
vim.keymap.set('n', '<C-q>', '<C-v>', { desc = 'Visual Block Mode' })
vim.keymap.set('n', '<leader>z', '<S-z><S-z>', { desc = 'Write buffer and close window' })

-- Source files
vim.keymap.set('n', '<A-s>', '<Cmd>source %<CR>', { desc = 'Source current file' })

-- Set current directory to parent of file
vim.keymap.set('n', '<leader>d', '<Cmd>:cd %:p:h<CR>', { desc = 'Set current directory to parent' })

-- Open specific file (painfully lazy)
vim.keymap.set('n', '<F1>', '<Cmd>sp ~/.config/nvim/todo.md<CR>', { desc = 'TODO Split' })
vim.keymap.set('n', '<F2>', '<Cmd>sp ~/.config/nvim/init.lua<CR>', { desc = 'init.lua Split' })
vim.keymap.set('n', '<F3>', '<Cmd>sp ~/.config/nvim/lua/oliver/keymaps.lua<CR>', { desc = 'Keymap Split' })

-- Terminal
vim.keymap.set('n', '<A-i>', '<Cmd>tabnew | term<CR>a', { desc = 'Open CL[I]' })
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Colorscheme
vim.keymap.set('n', '<leader>c', function() builtin.colorscheme {} end, { desc = '[C]olor Scheme' })

-- Background (dark/light)
vim.keymap.set('n', '<Leader>b', function()
    if vim.o.background == "dark" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end
end, { desc = "Toggle dark/light [B]ackground" })

-- Window
vim.keymap.set('n', '<leader>j', '<C-w>j', { desc = 'Window down[j]' })
vim.keymap.set('n', '<leader>k', '<C-w>k', { desc = 'Window up[k]' })
vim.keymap.set('n', '<leader>h', '<C-w>h', { desc = 'Window left[h]' })
vim.keymap.set('n', '<leader>l', '<C-w>l', { desc = 'Window right[l]' })

-- Escape Insert mode
vim.keymap.set('i', 'jk', '<Esc>')

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>td', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = '[T]oggle [D]iagnostics' })
