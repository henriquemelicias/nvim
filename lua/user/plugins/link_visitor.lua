return {
    "xiyaowong/link-visitor.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        local link_visitor = require("link-visitor")

        link_visitor.setup()

        wk.register({
            p = {
                l = { function() link_visitor.link_under_cursor() end, "Open link under cursor" },
                L = { function() link_visitor.link_near_cursor() end, "Open link near cursor" },
            }
        }, { mode = "n", prefix = "<leader>" })
    end
}
