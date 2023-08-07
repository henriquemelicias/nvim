return {
	"kdheepak/lazygit.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	keys = function()
		local wk = require("which-key")

        -- stylua: ignore
		wk.register({
			name = "+git",
			l = { ":LazyGit<CR>", "Lazy git" },
		}, { mode = "n", prefix = "<leader>g" })
	end,
}
