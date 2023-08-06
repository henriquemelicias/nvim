-- Dashboard for neovim at the start.
return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			[[                               __                ]],
			[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
			[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
			[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
			[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
			[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
		}
		dashboard.section.buttons.val = {
			dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("SPC f f", " " .. " Find file", ":Telescope find_files <CR>"),
			dashboard.button("SPC f o", " " .. " Recent files", ":Telescope oldfiles <CR>"),
			dashboard.button("SPC f g", " " .. " Find text", ":Telescope live_grep <CR>"),
			dashboard.button("SPC F f", " " .. " Frecency/MRU", ":Telescope frecency <CR>"),
			dashboard.button("SPC F p", " " .. " Projects", ":Telescope project<CR>"),
			dashboard.button("SPC F r", " " .. " Git Repos", ":Telescope repo<CR>"),
			dashboard.button(
				"SPC s r",
				" " .. " Restore last session",
				[[:lua require("persistence").load({ last = true }) <cr>]]
			),
			dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
			dashboard.button("q", " " .. " Quit", ":qa<CR>"),
		}
		local function footer()
			return "henriquemelicias"
		end

		dashboard.section.footer.val = footer()

		dashboard.section.footer.opts.hl = "Type"
		dashboard.section.header.opts.hl = "Include"
		dashboard.section.buttons.opts.hl = "Keyword"

		dashboard.opts.opts.noautocmd = true

		require("alpha").setup(dashboard.opts)
	end,
}
