local terminal_augroup = vim.api.nvim_create_augroup('terminal-insert', { clear = true })

-- Turn off list option for terminals
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function() vim.wo.list = false end,
})

-- Enter a terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
  group = terminal_augroup,
  callback = function() vim.cmd.startinsert() end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = terminal_augroup,
  callback = function()
    if vim.bo.buftype == 'terminal' then vim.cmd.startinsert() end
  end,
})

-- List Plugins
vim.api.nvim_create_user_command(
  'Plugins',
  function ()
    print (
      vim.iter(vim.pack.get())
        :map(function (x) return x.spec.name end)
        :totable()
    )
  end,
  {}
)
