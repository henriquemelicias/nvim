return {
	"folke/which-key.nvim",
	lazy = true,
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")

        -- stylua: ignore
        wk.register( {
            ["<leader>"] = { name = "+Leader" },
            ["<C-w>"] = { name = "+Window" },
	        ["<M-t>"] = { name = "+Tabs" },
            ["["] = { name = "+Previous" },
            ["]"] = { name = "+Next" },
        } )
	end,
	opts = {
		window = {
			border = "double",
		},
	},
}
