return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		cmdline = {
			view = "cmdline",
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			hover = {
				enabled = false,
			},
			signature = {
				enabled = false,
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = true,
			command_palette = false,
			long_message_to_split = true,
			inc_rename = true,
		},
	},
	keys = function()
		local wk = require("which-key")

		wk.register({
			name = "+cmd",
			l = {
				function()
					require("noice").cmd("last")
				end,
				"CMD last message",
			},
			h = {
				function()
					require("noice").cmd("history")
				end,
				"CMD history",
			},
			a = {
				function()
					require("noice").cmd("all")
				end,
				"CMD all",
			},
			d = {
				function()
					require("noice").cmd("dismiss")
				end,
				"CMD dismiss all",
			},
		}, { mode = "n", prefix = "<leader>c" })

		return {
			{
				"<c-f>",
				function()
					if not require("noice.lsp").scroll(4) then
						return "<c-f>"
					end
				end,
				silent = true,
				expr = true,
				desc = "CMD scroll forward commands",
				mode = { "i", "n", "s" },
			},
			{
				"<c-b>",
				function()
					if not require("noice.lsp").scroll(-4) then
						return "<c-b>"
					end
				end,
				silent = true,
				expr = true,
				desc = "CMD scroll backward commands",
				mode = { "i", "n", "s" },
			},
		}
	end,
}
