return {
	"mbbill/undotree",
	event = "VeryLazy",
	config = function()
		vim.g.undotree_SplitWidth = 40

		-- Add command to toggle undotree with window size reset.
		local api = vim.api

		local function setUndotreeWinSize()
			local winList = api.nvim_list_wins()
			for _, winHandle in ipairs(winList) do
				if
					api.nvim_win_is_valid(winHandle)
					and api.nvim_buf_get_option(api.nvim_win_get_buf(winHandle), "filetype") == "undotree"
				then
					api.nvim_win_set_width(winHandle, vim.g.undotree_SplitWidth)
				end
			end
		end
		api.nvim_create_user_command("UndotreeResetToggle", function()
			api.nvim_cmd(api.nvim_parse_cmd("UndotreeToggle", {}), {})
			setUndotreeWinSize()
		end, { desc = "Undotree toggle with size reset" })
	end,
	keys = function()
		local wk = require("which-key")

		wk.register({
			["u"] = {
				function()
					vim.cmd([[UndotreeResetToggle]])
					vim.cmd([[UndotreeFocus]])
				end,
				"Undo Tree",
			},
		}, {
			prefix = "<leader>",
		})
	end,
}
