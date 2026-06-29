vim.o.hlsearch = false

-- Persist colorscheme across sessions
local cs_file = vim.fn.stdpath 'config' .. '/colorscheme'
if vim.fn.filereadable(cs_file) == 1 then
  local cs = vim.fn.readfile(cs_file)[1]
  if cs and cs ~= '' then vim.cmd.colorscheme(cs) end
end

-- Turn off list option for terminals
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function() vim.wo.list = false end,
})

