-- Fancy looking tabs.
return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			close_command = function(n)
				require("mini.bufremove").delete(n, false)
			end,
			right_mouse_command = function(n)
				require("mini.bufremove").delete(n, false)
			end,
			show_buffer_close_icons = false,
			show_close_icon = false,
			always_show_bufferline = false,
			show_tab_indicators = false,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(_, _, diag)
				local icons = require("user.configs.settings").ICONS.DIAGNOSTICS
				local ret = (diag.error and icons.Error .. diag.error .. " " or "")
					.. (diag.warning and icons.Warn .. diag.warning or "")
				return vim.trim(ret)
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "Neo-tree",
					highlight = "Directory",
					text_align = "left",
				},
				{
					filetype = "neo-tree",
					text = "Neo-tree",
					highlight = "Directory",
					text_align = "right",
				},
			},
		},
	},
	keys = function()
		local wk = require("which-key")

        -- stylua: ignore
		wk.register({
			name = "+bufferline",
			c = {
				name = "+close",
				h = { ":BufferLineCloseLeft<CR>", "Close left buffers" },
				l = { ":BufferLineCloseRight<CR>", "Close right buffers" },
				o = { ":BufferLineCloseOthers<CR>", "Close the other buffers" },
				d = { ":BufferLineGroupClose ungrouped<CR>", "Delete non-pinned buffers" }, -- Create/close tabs.
			},
			g = { ":lua require('bufferline').go_to(vim.fn.input('Buffer number: '))<CR>", "Go to buffer ..." },
			h = { ":bprevious<CR>", "Go to the previous buffer" },
			l = { ":bnext<CR>", "Go the the next buffer" },
			p = { ":BufferLineTogglePin<CR>", "Toggle buffer pin" },
			n = { ":tabnew<CR>", "Create new buffer" },
			s = {
				name = "+sort",
				d = { ":BufferLineSortByDirectory<CR>", "Sort buffers by directory" },
				e = { ":BufferLineSortByExtension<CR>", "Sort buffers by extension" },
				r = { ":BufferLineSortByRelativeDirectory<CR>", "Sort buffers by relative dir" },
				t = { ":BufferLineSortByTabs<CR>", "Sort buffers by tabs" },
			},
			["1"] = { ":BufferLineGoToBuffer 1<CR>", "Go to buffer 1" },
			["2"] = { ":BufferLineGoToBuffer 2<CR>", "Go to buffer 2" },
			["3"] = { ":BufferLineGoToBuffer 3<CR>", "Go to buffer 3" },
			["4"] = { ":BufferLineGoToBuffer 4<CR>", "Go to buffer 4" },
			["5"] = { ":BufferLineGoToBuffer 5<CR>", "Go to buffer 5" },
			["6"] = { ":BufferLineGoToBuffer 6<CR>", "Go to buffer 6" },
			["7"] = { ":BufferLineGoToBuffer 7<CR>", "Go to buffer 7" },
			["8"] = { ":BufferLineGoToBuffer 8<CR>", "Go to buffer 8" },
			["9"] = { ":BufferLineGoToBuffer 9<CR>", "Go to buffer 9" },
		}, { mode = "n", prefix = "<leader>b" })
	end,
}
