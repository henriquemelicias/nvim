return {
	"folke/which-key.nvim",
	lazy = true,
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300

		local wk = require("which-key")

        -- stylua: ignore
        wk.register( {
            ["<C-w>"] = { name = "+Window" },
	        ["<M-t>"] = { name = "+Tabs" },
            ["["] = { name = "+Previous" },
            ["]"] = { name = "+Next" },
            ["g"] = { namea = "+Goto" },
            ["<leader>"] = { name = "+Leader" },
            ["<leader>l"] = { name = "+lsp" },
            ["<leader>x"] = { name = "+test (eXperiment)" },
            ["<leader>pw"] = { name = "+workspace" }
        } )
	end,
	opts = {
		window = {
			border = "double",
		},
	},
}
