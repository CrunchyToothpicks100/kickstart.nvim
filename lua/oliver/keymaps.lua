local builtin = require 'telescope.builtin'

-- ':W' will show a full list of keymaps

-- Basic
vim.keymap.set('n', '<S-j>', '<C-e>', { desc = 'Scroll Down' })
vim.keymap.set('n', '<S-k>', '<C-y>', { desc = 'Scroll Up' })
vim.keymap.set('n', '<C-q>', '<C-v>', { desc = 'Visual Block Mode' })

-- Reload
vim.keymap.set('n', '<A-s>', function ()
    local root = '~/.config/nvim/'
    local source_files = {'init.lua', 'lua/oliver/keymaps.lua', 'lua/oliver/options.lua'}
    for _, value in ipairs(source_files) do
        vim.cmd("source " .. root .. value)
        print('Hello, ' .. value .. '!')
    end
end, { desc = 'Reload source files' })

-- Window
vim.keymap.set('n', '<leader>j', '<C-w>j', { desc = 'Window down[j]' })
vim.keymap.set('n', '<leader>k', '<C-w>k', { desc = 'Window up[k]' })
vim.keymap.set('n', '<leader>h', '<C-w>h', { desc = 'Window left[h]' })
vim.keymap.set('n', '<leader>l', '<C-w>l', { desc = 'Window right[l]' })
vim.keymap.set('n', '<leader><S-j>', '<C-w>J<Cmd>res 17<CR>', { desc = 'Move window down[j]' })
vim.keymap.set('n', '<leader><S-k>', '<C-w>K<Cmd>res 17<CR>', { desc = 'Move window up[k]' })
vim.keymap.set('n', '<leader><S-h>', '<C-w>H', { desc = 'Move window left[h]' })
vim.keymap.set('n', '<leader><S-l>', '<C-w>L', { desc = 'Move window right[l]' })
vim.keymap.set('n', '<leader>z', '<S-z><S-z>', { desc = 'Write and Quit' })

-- Tabs
vim.keymap.set('n', '<A-[>', 'gT', { desc = 'Previous tab' })
vim.keymap.set('n', '<A-]>', 'gt', { desc = 'Next tab' })

-- Open specific file
vim.keymap.set('n', '<F1>', '<Cmd>sp ~/Notes/comp_sci/nvim_todo.md<CR>', { desc = 'TODO Split' })
vim.keymap.set('n', '<F2>', '<Cmd>sp ~/.config/nvim/init.lua<CR>', { desc = 'init.lua Split' })
vim.keymap.set('n', '<F3>', '<Cmd>sp ~/.config/nvim/lua/oliver/keymaps.lua<CR>', { desc = 'Keymap Split' })

-- Terminal
vim.keymap.set('n', '<A-i>', '<Cmd>term<CR>a', { desc = 'Open CL[I]'})
vim.keymap.set('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Colorscheme
vim.keymap.set('n', '<leader>c', function()
  builtin.colorscheme {
    attach_mappings = function(prompt_bufnr, _)
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          vim.cmd.colorscheme(selection.value)
          vim.fn.writefile({ selection.value }, vim.fn.stdpath 'config' .. '/colorscheme')
        end
      end)
      return true
    end,
  }
end, { desc = '[C]olor Scheme' })
vim.keymap.set('n', '<Leader>b', function()
    if vim.o.background == "dark" then
        vim.o.background = "light"
    else
        vim.o.background = "dark"
    end
end, { desc = "Toggle dark/light [B]ackground" })

-- Escape Insert mode
vim.keymap.set('i', 'jk', '<Esc>')

-- Diagnostics
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>td', function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = '[T]oggle [D]iagnostics' })

