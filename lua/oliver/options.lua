vim.o.hlsearch = false

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.backupcopy = 'yes'

-- Persist colorscheme and background across sessions
local config_dir = vim.fn.stdpath 'config'

local bg_file = config_dir .. '/background'
if vim.fn.filereadable(bg_file) == 1 then
  local bg = vim.fn.readfile(bg_file)[1]
  if bg == 'light' or bg == 'dark' then vim.o.background = bg end
end

local cs_file = config_dir .. '/colorscheme'
if vim.fn.filereadable(cs_file) == 1 then
  local cs = vim.fn.readfile(cs_file)[1]
  if cs and cs ~= '' then vim.cmd.colorscheme(cs) end
end

vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = function()
    vim.fn.writefile({ vim.o.background }, bg_file)
  end,
})

