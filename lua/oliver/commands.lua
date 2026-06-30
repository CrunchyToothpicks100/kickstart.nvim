-- Turn off list option for terminals
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function() vim.wo.list = false end,
})

-- List Plugins
vim.api.nvim_create_user_command(
  'Plugins',
  function ()
    print (
      table.concat(
        vim.iter(vim.pack.get())
          :map(function (x) return x.spec.name end)
          :totable(),
        '\n'
      )
    )
  end,
  {}
)
