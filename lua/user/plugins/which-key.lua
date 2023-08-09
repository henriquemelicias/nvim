return {
	"folke/which-key.nvim",
	lazy = true,
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")

        -- stylua: ignore
        wk.register( {
            ["["] = { name = "+Previous" },
            ["]"] = { name = "+Next" },
            ["<leader>"] = { name = "+Leader" },
            ["<leader>x"] = { name = "+test (eXperiment)" },
        } )
	end,
	opts = {
		window = {
			border = "double",
		},
	},
}
