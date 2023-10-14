return {
	-- Add docker to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "dockerfile" })
			end
		end,
	},
	{
		"mason.nvim",
		optional = true,
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(
				opts.ensure_installed,
				{ "dockerfile-language-server", "docker-compose-language-service", "hadolint" }
			)
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local null_ls = require("null-ls")
			opts.sources = opts.sources or {}
			vim.list_extend(opts.sources, {
				null_ls.builtins.diagnostics.hadolint,
			})
		end,
	},
	-- Correctly setup lspconfig for clangd 🚀
	{
		"neovim/nvim-lspconfig",
		optinal = true,
		opts = {
			servers = {
				dockerls = {},
				docker_compose_language_service = {},
			},
			setup = {
				dockerls = function(_, _)
					require("which-key").register({ ["<leader>l"] = { name = "+lsp", l = { name = "+docker" } } })
					return false
				end,
				docker_compose_language_service = function(_, _)
					require("which-key").register({
						["<leader>l"] = { name = "+lsp", l = { name = "+docker-compose" } },
					})
					return false
				end,
			},
		},
	},
}
