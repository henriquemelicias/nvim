return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
        suggestion = {
            enabled = false,
        },
        panel = {
            enabled = false,
        },
        filetypes = {
            markdown = true,
            help = true,
        },

        advanced = {
            listCount = 10,
            inlineSuggestCount = 5,
        }
    },
    keys = function()
        local wk = require("which-key")

        -- stylua: ignore
        wk.register({
            p = {
                c = { "<cmd>Copilot panel<CR>", "Copilot panel" },
            },
        }, {
            mode = "n",
            prefix = "<leader>",
        })
    end,
}
