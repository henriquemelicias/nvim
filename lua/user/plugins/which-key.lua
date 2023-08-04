return {
    "folke/which-key.nvim",
    lazy = true,
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300

        local wk = require( "which-key" )

        wk.register( {
            ["<leader>"] = {
                name = "+Leader"
            },
            ["["] = {
                name = "+Previous"
            },
            ["]"] = {
                name = "+Next"
            },
            ["<C-T>"] = {
                name = "+Tabs"
            },
            ["<C-W>"] = {
                name = "+Window"
            },
        } )
    end,
    opts = {
        window = {
            border = "double",
        },
    },
}
