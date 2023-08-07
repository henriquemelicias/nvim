return {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = function ()
        local wk = require( "which-key" )

        -- stylua: ignore
        wk.register( {
            g = { ":Git<CR>", "Fugitive" },
        }, { mode = "n", prefix = "<leader>g"} )
    end
}
