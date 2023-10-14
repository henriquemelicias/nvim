return {
	-- Add shell to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
        optional = true,
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "bash" })
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		optional = true,
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(
					opts.ensure_installed,
					{ "bash-language-server", "bash-debug-adapter", "shfmt", "beautysh", "shellharden" }
				)
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local null_ls = require("null-ls")
			opts.sources = opts.sources or {}
			vim.list_extend(opts.sources, {
                null_ls.builtins.formatting.shfmt.with({
                    filetypes = { "bash", "ksh", "sh" }
                }),
                null_ls.builtins.formatting.beautysh.with({
                    filetypes = { "csh", "zsh" },
                }),
                null_ls.builtins.formatting.shellharden.with({
                    filetypes = { "bash", "csh", "ksh", "sh", "zsh" }
                }),
                null_ls.builtins.diagnostics.zsh.with({
                    filetypes = { "zsh" },
                }),

			})
		end,
	},
	-- Correctly setup lspconfig for clangd 🚀
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				bashls = {
					keys = {},
				},
			},
			setup = {
				bashls = function(_, _)
					require("which-key").register({ ["<leader>l"] = { name = "+lsp", l = { name = "+sh" } } })
					return false
				end,
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		optional = true,
		opts = function()
			local dap = require("dap")
			if not dap.adapters["bashdb"] then
				require("dap").adapters["bashdb"] = {
					type = "executable",
					command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
					name = "bashdb",
				}
			end
			for _, lang in ipairs({ "sh" }) do
				dap.configurations[lang] = {
					{
						type = "bashdb",
						request = "launch",
						name = "Launch file",
						showDebugOutput = true,
						pathBashdb = vim.fn.stdpath("data")
							.. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
						pathBashdbLib = vim.fn.stdpath("data")
							.. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
						trace = true,
						file = "${file}",
						program = "${file}",
						cwd = "${workspaceFolder}",
						pathCat = "cat",
						pathBash = "/bin/bash",
						pathMkfifo = "mkfifo",
						pathPkill = "pkill",
						args = {},
						env = {},
						terminalKind = "integrated",
					},
				}
			end
		end,
	},
}
