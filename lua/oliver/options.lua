vim.o.hlsearch = false

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Persist colorscheme across sessions
local cs_file = vim.fn.stdpath 'config' .. '/colorscheme'
if vim.fn.filereadable(cs_file) == 1 then
  local cs = vim.fn.readfile(cs_file)[1]
  if cs and cs ~= '' then vim.cmd.colorscheme(cs) end
end

