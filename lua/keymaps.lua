local tele = require 'telescope.builtin'

-- ':W' will show a full list of keymaps

-- Basic
vim.keymap.set('n', '<leader>v', '<C-v>', { desc = 'Visual Block Mode' })
vim.keymap.set('n', '<leader>z', '<S-z><S-z>', { desc = 'Write buffer and close window' })
vim.keymap.set('n', '<A-[>', 'gT', { desc = 'tab left' })
vim.keymap.set('n', '<A-]>', 'gt', { desc = 'tab right' })
vim.keymap.set('n', '<leader>r', '<Cmd>e!<CR>', { desc = 'Refresh editor' })
vim.keymap.set('n', '<leader>w', '070lf<Space>xi<CR><Esc>', { desc = 'Hard Wrap' })
vim.keymap.set('n', '<leader>oj', 'o<Esc>', { desc = 'New line below' })
vim.keymap.set('n', '<leader>ok', 'O<Esc>', { desc = 'New line above' })

-- Web Dev
vim.keymap.set('n', '<leader>hs', '_f>a<CR><Esc>$F<i<CR><Esc>k', { desc = 'split HTML tags' })
vim.keymap.set('n', '<leader>x', '_f<Space>x', { desc = 'Delete first space in line' })
vim.keymap.set('n', '<leader>X', '$F<Space>x', { desc = 'Delete last space in line' })
vim.keymap.set('n', '<leader>ht', 'saa>}saa>/saa>*saa><Space>', { remap = true, desc = 'Comment HTML tag' })

-- Source files
vim.keymap.set('n', '<A-s>', '<Cmd>source %<CR>', { desc = 'Source current lua file' })

-- Terminal
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Colorscheme
vim.keymap.set('n', '<leader>cs', function() tele.colorscheme {} end, { desc = '[C]olor Scheme' })

-- Background (dark/light)
vim.keymap.set('n', '<Leader>tl', function()
  if vim.o.background == 'dark' then
    vim.o.background = 'light'
  else
    vim.o.background = 'dark'
  end
end, { desc = '[T]oggle [L]ight/Dark Background' })

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>td', function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, { desc = '[T]oggle [D]iagnostics' })

-- Toggle Colorizer
vim.keymap.set('n', '<leader>tc', '<Cmd>ColorizerToggle<CR>', { desc = 'Toggle [C]olorizer' })

-- Peek.nvim
vim.keymap.set('n', '<leader>po', '<Cmd>PeekOpen<CR>', { desc = 'Open markdown preview' })
vim.keymap.set('n', '<leader>pc', '<Cmd>PeekClose<CR>', { desc = 'Close markdown preview' })

-- ================
-- INSERT MODE
-- ================

-- <Esc>
vim.keymap.set('i', 'jk', '<Esc>')
