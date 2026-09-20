-- List Plugins
vim.api.nvim_create_user_command('Plugins', function()
  print(table.concat(vim.iter(vim.pack.get()):map(function(x) return x.spec.name end):totable(), '\n'))
end, {})

-- LspInfo alias
vim.api.nvim_create_user_command('LspInfo', 'checkhealth vim.lsp', {})
