return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	keys = {
		{
			"<leader>U",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "Dismiss all Notifications",
		},
	},
	opts = {
		timeout = 5000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
	},
}
