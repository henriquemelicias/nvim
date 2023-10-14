return {
	{
		"mason.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "tailwindcss-language-server", "rustywind" })
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local null_ls = require("null-ls")
			opts.sources = opts.sources or {}
			vim.list_extend(opts.sources, {
				null_ls.builtins.formatting.rustywind.with({
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
						"vue",
						"svelte",
						"html",
						"rust",
					},
					command = "rustywind",
				}),
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
        optional = true,
		opts = {
			servers = {
				tailwindcss = {
					filetypes_exclude = { "markdown" },
				},
			},
			setup = {
				tailwindcss = function(_, opts)
					local tw = require("lspconfig.server_configurations.tailwindcss")
					--- @param ft string
					opts.filetypes = vim.tbl_filter(function(ft)
						return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
					end, tw.default_config.filetypes)
				end,
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
        optional = true,
		dependencies = {
			{ "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
		},
		opts = function(_, opts)
			-- original LazyVim kind icon formatter
			local format_kinds = opts.formatting.format
			opts.formatting.format = function(entry, item)
				format_kinds(entry, item) -- add icons
				return require("tailwindcss-colorizer-cmp").formatter(entry, item)
			end
		end,
	},
}
