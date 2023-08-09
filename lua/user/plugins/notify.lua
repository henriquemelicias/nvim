return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
    -- stylua: ignore
	keys = {
		{ "<leader>Un", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss all notifications" },
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
