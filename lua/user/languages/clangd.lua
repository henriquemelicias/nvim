return {
	-- Add C/C++ to treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		optional = true,
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "c", "cpp" })
			end
		end,
	},
	{
		-- Ensure C/C++ debugger is installed
		"williamboman/mason.nvim",
		optional = true,
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "clangd", "codelldb", "clang-format" })
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		optional = true,
		opts = function(_, opts)
			local null_ls = require("null-ls")
			local formats_dir = require("user.configs.settings").FORMATS_DIR
			opts.sources = opts.sources or {}
			vim.list_extend(opts.sources, {
				null_ls.builtins.formatting.clang_format.with({
					filetypes = { "c", "cpp", "cs", "java", "cuda", "proto" },
					extra_args = { "--style", "file:" .. formats_dir .. "custom.clang-format" },
				}),
				null_ls.builtins.diagnostics.clang_check,
			})
		end,
	},
	-- Correctly setup lspconfig for clangd
	{
		"neovim/nvim-lspconfig",
		optional = true,
		opts = {
			servers = {
				-- Ensure mason installs the server
				clangd = {
					keys = {},
					root_dir = function(fname)
						return require("lspconfig.util").root_pattern(
							"Makefile",
							"configure.ac",
							"configure.in",
							"config.h.in",
							"meson.build",
							"meson_options.txt",
							"build.ninja"
						)(fname) or require("lspconfig.util").root_pattern(
							"compile_commands.json",
							"compile_flags.txt"
						)(fname) or require("lspconfig.util").find_git_ancestor(fname)
					end,
					capabilities = {
						offsetEncoding = { "utf-16" },
					},
					cmd = {
						"clangd",
						"--background-index",
						"--clang-tidy",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--fallback-style=llvm",
					},
					init_options = {
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
			},
			setup = {
				clangd = function(_, opts)
					require("which-key").register({ ["<leader>l"] = { name = "+lsp", l = { name = "+C/C++" } } })
					local clangd_ext_opts = require("user.utils").opts("clangd_extensions.nvim")
					require("clangd_extensions").setup(
						vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts })
					)
					return true
				end,
			},
		},
	},
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		config = function() end,
		opts = {
			extensions = {
				inlay_hints = {},
				ast = {
					--These require codicons (https://github.com/microsoft/vscode-codicons)
					role_icons = {
						type = "",
						declaration = "",
						expression = "",
						specifier = "",
						statement = "",
						["template argument"] = "",
					},
					kind_icons = {
						Compound = "",
						Recovery = "",
						TranslationUnit = "",
						PackExpansion = "",
						TemplateTypeParm = "",
						TemplateTemplateParm = "",
						TemplateParamObject = "",
					},
				},
			},
			server = {
				on_attach = function(_, bufnr)
					local wk = require("which-key")
					wk.register({
						l = {
							name = "+C/C++",
							s = { "<cmd>ClangdSwitchSourceHeader<cr>", "Switch Source/Header" },
							m = { "<cmd>ClangdMemoryUsage<cr>", "Memory usage" },
						},
					}, { mode = "n", prefix = "<leader>l", buffer = bufnr })
				end,
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		optional = true,
		opts = function()
			local dap = require("dap")
			if not dap.adapters["codelldb"] then
				require("dap").adapters["codelldb"] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "codelldb",
						args = {
							"--port",
							"${port}",
						},
					},
				}
			end
			for _, lang in ipairs({ "c", "cpp" }) do
				dap.configurations[lang] = {
					{
						type = "codelldb",
						request = "launch",
						name = "Launch file",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
					},
					{
						type = "codelldb",
						request = "attach",
						name = "Attach to process",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},
	{
		"nvim-cmp",
		opts = function(_, opts)
			table.insert(opts.sorting.comparators, 1, require("clangd_extensions.cmp_scores"))
		end,
	},
}
