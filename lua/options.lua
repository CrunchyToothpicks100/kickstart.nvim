vim.o.hlsearch = false
vim.o.cursorline = false

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.undofile = true
vim.o.undodir = vim.fn.expand '~/.config/nvim/undofiles'

vim.o.backupcopy = 'yes'

vim.cmd.colorscheme 'tokyonight-night'

-- vim.o.background = 'light'

-- Don't auto-continue comments
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function() vim.opt_local.formatoptions:remove { 'o', 'r' } end,
})

-- Turn off list option for terminals
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function() vim.wo.list = false end,
})
