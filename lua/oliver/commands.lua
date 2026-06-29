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
