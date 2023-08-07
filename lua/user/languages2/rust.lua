return {
	-- Ensure Rust debugger is installed
	{
		"williamboman/mason.nvim",
		optional = true,
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "codelldb" })
			end
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		lazy = true,
		opts = function()
			local ok, mason_registry = pcall(require, "mason-registry")
			local adapter ---@type any
			if ok then
				-- rust tools configuration for debugging support
				local codelldb = mason_registry.get_package("codelldb")
				local extension_path = codelldb:get_install_path() .. "/extension/"
				local codelldb_path = extension_path .. "adapter/codelldb"
				local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
					or extension_path .. "lldb/lib/liblldb.so"
				adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
			end
			return {
				dap = {
					adapter = adapter,
				},
				tools = {
					on_initialized = function()
						vim.cmd([[
                            augroup RustLSP
                            autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                            autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                            autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                            augroup END
                        ]])
					end,
					inlay_hints = {
						only_current_line = true,
					},
					hover_actions = {
						auto_focus = true,
					},
				},

				server = {
					on_attach = function(_, bufnr)
						local wk = require("which-key")
						local rust_tools = require("rust-tools")
						wk.register({
							name = "+lsp",
							l = {
								name = "+rust",
								a = { rust_tools.hover_actions.hover_actions, "Hover actions" },
								d = { rust_tools.debuggables.debuggables, "Debuggables" },
								D = { ":RustLastDebug<CR>", "Last debuggable" },
								h = { rust_tools.inlay_hints.enable, "Enable inlay hints" },
								H = { rust_tools.inlay_hints.disable, "Disable inlay hints" },
								r = { rust_tools.runnables.runnables, "Runnables" },
								j = { rust_tools.join_lines.join_lines, "Join lines" },
								R = { ":RustLastRun<CR>", "Last runnable" },
								m = { rust_tools.expand_macro.expand_macro, "Expand macro" },
								c = { rust_tools.open_cargo_toml.open_cargo_toml, "Open cargo.toml" },
								p = { rust_tools.parent_module.parent_module, "Go to parent module" },
								s = { ":RustSSR<CR>", "Structural search and replace" },
							},
						}, { mode = "n", prefix = "<leader>l", buffer = bufnr })
					end,
				},
			}
		end,
		config = function() end,
	},

	-- Correctly setup lspconfig for Rust 🚀
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				-- Ensure mason installs the server
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
								loadOutDirsFromCheck = true,
								runBuildScripts = true,
							},
							-- Add clippy lints for Rust.
							checkOnSave = {
								allFeatures = true,
								command = "clippy",
								extraArgs = { "--no-deps" },
							},
							procMacro = {
								enable = true,
								ignored = {
									["async-trait"] = { "async_trait" },
									["napi-derive"] = { "napi" },
									["async-recursion"] = { "async_recursion" },
								},
							},
						},
					},
				},
				taplo = {
					keys = {
						{
							"K",
							function()
								if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
									require("crates").show_popup()
								else
									vim.lsp.buf.hover()
								end
							end,
							desc = "Show Crate Documentation",
						},
					},
				},
			},
			setup = {
				rust_analyzer = function(_, opts)
					local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
					require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
					return true
				end,
			},
		},
	},

	{
		"nvim-neotest/neotest",
		optional = true,
		dependencies = {
			"rouge8/neotest-rust",
		},
		opts = {
			adapters = {
				["neotest-rust"] = {},
			},
		},
	},
}
