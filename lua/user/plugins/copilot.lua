return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require( "copilot" ).setup({
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false
            },
        })

        require('copilot_cmp').setup()
    end,
    dependencies = {
        {
            "zbirenbaum/copilot-cmp",
            lazy = true,
            config = false,
        }
    },
    keys = function()

        local wk = require( "which-key" )

        wk.register({
            p = {
                c = { "<cmd>Copilot panel<CR>", "Copilot panel" },
            },
        }, {
            mode = "n",
            prefix = "<leader>",
        })
    end
}
