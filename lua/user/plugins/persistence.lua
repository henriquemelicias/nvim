--  Session management. This saves your session in the background, keeping track of open buffers, window arrangement, and more. You can restore sessions when returning through the dashboard.
return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	opts = { options = { "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
	keys = function()
		local wk = require("which-key")

        -- stylua: ignore
		wk.register({
			name = "+session",
			l = { function() require("persistence").load() end, "Restore session for current directory/project" },
			r = { function() require("persistence").load({ last = true }) end, "Restore last session" },
			d = { function() require("persistence").stop() end, "Don't save current session" },
		}, { mode = "n", prefix = "<leader>s" })
	end,
}
