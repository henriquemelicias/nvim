return {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    keys = function ()
        local wk = require( "which-key" )

        wk.register( {
            f = { ":Git", "Fugitive" },
        }, { mode = "n", prefix = "<leafer>g"} )
    end
}
