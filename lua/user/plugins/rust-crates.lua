return { -- Cargo.toml crates dependencies manager
	"saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	config = function()
		require("crates").setup({
			popup = {
				autofocus = true,
			},
		})
	end,
	keys = function()
		local wk = require("which-key")
		wk.register({
			name = "+rust",
			c = {
				name = "+crates",
				c = { "<cmd>lua require('crates').show_popup()<CR>", "Show crate info" },
				f = { "<cmd>lua require('crates').show_features_popup()<CR>", "Show crate features" },
				v = { "<cmd>lua require('crates').show_versions_popup()<CR>", "Show crate versions" },
				d = { "<cmd>lua require('crates').show_dependencies_popup()<CR>", "Show crate dependencies" },
				t = {
					"<cmd>lua require('crates').expand_plain_crate_to_inline_table()<CR>",
					"Current line crate into inline table",
				},
				T = { "<cmd>lua require('crates').extract_crate_into_table()<CR>", "Current line crate into table" },
				u = { "<cmd>lua require('crates').upgrade_crate()<CR>", "Upgrade current crate" },
				U = { "<cmd>lua require('crates').upgrade_all_crates()<CR>", "Upgrade all crates" },
			},
			C = {
				name = "+crates goto",
				h = { "<cmd>lua require('crates').open_homepage()<CR>", "Homepage" },
				r = { "<cmd>lua require('crates').open_repository()<CR>", "Repository" },
				d = { "<cmd>lua require('crates').open_documentation()<CR>", "Documentation" },
				c = { "<cmd>lua require('crates').open_crates_io()<CR>", "Crates IO" },
			},
		}, { mode = "n", prefix = "<leader>ll" })

		wk.register({
			name = "+lsp",
            l = {
                name = "+rust",
                c = {
                    name = "+crates",
                    u = { "<cmd>lua require('crates').upgrade_crates()<CR>", "Upgrade crates" },
                },
            },
		}, { mode = "v", prefix = "<leader>ll" })
	end,
}
