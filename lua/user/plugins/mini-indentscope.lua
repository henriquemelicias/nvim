return {
	"echasnovski/mini.indentscope",
	version = false, -- wait till new 0.7.0 release to put it back on semver
	event = { "BufReadPre", "BufNewFile" },
	opts = {
        draw = {
            delay = 0,
        },
		symbol = "▏",
		options = { try_as_border = true },
	},
    config = function(_, opts)
        local indentscope = require("mini.indentscope")

		vim.cmd([[highlight MiniIndentscopeSymbol guifg=#FFFFFF gui=nocombine]])
		vim.cmd([[highlight MiniIndentscopeSymbolOff guisp=#FFFFFF gui=underline]])

        opts.draw.animation = indentscope.gen_animation.none()

        indentscope.setup(opts)
    end,
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
}
