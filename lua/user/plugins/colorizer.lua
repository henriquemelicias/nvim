-- Colorize color codes.
return {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local colorizer = require( "colorizer" )

        colorizer.setup {
            "*"; -- Highlight all files, but customize some others.
            "!gitcommit"; -- Exclude file.
            css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
            html = { mode = "background", names = true; } -- Disable parsing "names" like Blue or Gray
        }
    end
}
