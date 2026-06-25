-- Open Sidebar
vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

-- Insert mode
vim.keymap.set('i', 'jk', '<Esc>')

-- Shortcut for changing colorscheme
vim.keymap.set('n', '<leader>c', function() builtin.colorscheme {} end, {desc = '[C]olor [S]cheme'})

-- S-tier: habamax, tokyonight-night, tokyonight, tokyonight-moon, sorbet, miniwinter (dark), miniautumn (dark), slate, retrobox (light), minicyan (light)
-- A-tier: zaibatsu, minischeme (dark), minicyan (light), minisummer (light), miniautumn (light)
-- B-tier: retrobox (dark), unokai, minisummer (dark), miniautumn (dark), shine, minischeme (light)
-- C-tier: mlunaperche (light), lunaperche (dark), inicyan (dark), industry, pablo
-- D-tier: elflord
-- F-tier: delek, zellner

