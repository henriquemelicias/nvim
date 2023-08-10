-- Fancy looking tabs.
return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = {
			"echasnovski/mini.bufremove",
		},
		opts = {
			options = {
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
				mode = "tabs",
			},
		},
		keys = function()
			local wk = require("which-key")

        -- stylua: ignore
		wk.register({
			name = "+buffers",
            d = { function() require("mini.bufremove").delete(0, false) end, "Delete buffer" },
            D = { function() require("mini.bufremove").delete(0, true) end, "Delete buffer (force)" },
			h = { ":bprevious<CR>", "Go to the previous buffer" },
			H = { ":bfirst<CR>", "Go to the FIRST buffer" },
			l = { ":bnext<CR>", "Go the the next buffer" },
			L = { ":blast<CR>", "Go the the LAST buffer" },
			o = { ":e #<CR>", "Switch to other buffer" },
		}, { mode = "n", prefix = "<leader>b" })

        -- stylua: ignore
        wk.register({
            name = "+tabs",
			["<tab>"] = { ":tabnew<CR>", "Create new tab" },
            c = {
                name = "+close",
                h = { ":BufferLineCloseLeft<CR>", "Close left tabs" },
                l = { ":BufferLineCloseRight<CR>", "Close right tabs" },
                o = { ":BufferLineCloseOthers<CR>", "Close the other tabs" },
            },
            d = { ":tabclose<CR>", "Close tab" },
            D = { ":tabclose!<CR>", "Close tab (force)" },
            g = { ":lua require('bufferline').go_to(vim.fn.input('Tab number: '))<CR>", "Go to tab ..." },
			h = { ":tabprevious<CR>", "Go to the previous tab" },
			H = { ":tabfirst<CR>", "Go to the FIRST tab" },
			l = { ":tabnext<CR>", "Go the the next tab" },
			L = { ":tablast<CR>", "Go the the LAST tab" },
			p = { ":BufferLinePick<CR>", "Pick tab to go" },
			P = { ":BufferLinePickClose<CR>", "Pick tab to close" },
			["1"] = { ":BufferLineGoToBuffer 1<CR>", "Go to tab 1" },
			["2"] = { ":BufferLineGoToBuffer 2<CR>", "Go to tab 2" },
			["3"] = { ":BufferLineGoToBuffer 3<CR>", "Go to tab 3" },
			["4"] = { ":BufferLineGoToBuffer 4<CR>", "Go to tab 4" },
			["5"] = { ":BufferLineGoToBuffer 5<CR>", "Go to tab 5" },
			["6"] = { ":BufferLineGoToBuffer 6<CR>", "Go to tab 6" },
			["7"] = { ":BufferLineGoToBuffer 7<CR>", "Go to tab 7" },
			["8"] = { ":BufferLineGoToBuffer 8<CR>", "Go to tab 8" },
			["9"] = { ":BufferLineGoToBuffer 9<CR>", "Go to tab 9" },
        }, { mode = "n", prefix = "<leader><tab>"})
		end,
	},
}
