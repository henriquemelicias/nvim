return {
	"nvim-lualine/lualine.nvim",
	event = "VeryLazy",
	opts = function()
		local ICONS = require("user.configs.settings").ICONS

		local hide_in_width = function()
			return vim.fn.winwidth(0) > 100
		end

		local diagnostics = {
			"diagnostics",
			symbols = {
				error = ICONS.DIAGNOSTICS.Error,
				warn = ICONS.DIAGNOSTICS.Warm,
				info = ICONS.DIAGNOSTICS.Info,
				hint = ICONS.DIAGNOSTICS.Hint,
			},
			sources = { "nvim_diagnostic" },
			colored = true,
			update_in_insert = false,
			always_visible = false,
		}

		local diff = {
			"diff",
			colored = false,
			symbols = {
				added = ICONS.GIT.Added,
				modified = ICONS.GIT.Modified,
				removed = ICONS.GIT.Removed,
			},
			cond = hide_in_width,
		}

		local mode = {
			"mode",
			fmt = function(str)
				return "-- " .. str .. " --"
			end,
		}

		local branch = {
			"branch",
			icons_enabled = true,
			icon = ICONS.GIT.Branch,
		}

		local location = {
			"location",
			padding = 0,
		}

		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = { "alpha", "dashboard", "neo-tree", "Outline", "undotree", "diff" },
				ignore_focus = { "toggleterm" },
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { mode },
				lualine_b = { branch, diagnostics },
				lualine_c = {
					{ "filename", path = 1 },
					{
						function()
							return require("nvim-navic").get_location()
						end,
					},
				},
				lualine_x = {
					diff,
					{
						function()
							return "  " .. require("dap").status()
						end,
						cond = function()
							return package.loaded["dap"] and require("dap").status() ~= ""
						end,
					},
					{
						"filetype",
					},
				},
				lualine_y = { "progress" },
				lualine_z = { location },
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = { "lazy" },
		})
	end,
}
