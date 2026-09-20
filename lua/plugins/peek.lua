local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  { src = gh 'toppair/peek.nvim' },
}

local peek = require 'peek'

peek.setup {
  auto_load = true,
  close_on_bdelete = true,

  -- Use the system opener directly so WSL routes through xdg-open.
  app = { 'xdg-open' },

  syntax = true,
  theme = 'dark',

  update_on_change = true,

  filetype = { 'markdown' },

  throttle_at = 200000,
  throttle_time = 'auto',
}

vim.api.nvim_create_user_command('PeekOpen', peek.open, {})
vim.api.nvim_create_user_command('PeekClose', peek.close, {})
