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
                            c = {
                                name = "+crates",
                                c = { "<cmd>lua require('crates').show_popup()<CR>", "Show crate info" },
                                f = { "<cmd>lua require('crates').show_features_popup()<CR>", "Show crate features" },
                                v = { "<cmd>lua require('crates').show_versions_popup()<CR>", "Show crate versions" },
                                d = { "<cmd>lua require('crates').show_dependencies_popup()<CR>", "Show crate dependencies" },
                                t = { "<cmd>lua require('crates').expand_plain_crate_to_inline_table()<CR>", "Current line crate into inline table" },
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
						}, { mode = "n", prefix = "<leader>l", buffer = bufnr })

                        -- stylua: ignore
                        wk.register({
                            l = {
                                c = {
                                    name = "+crates",
                                    u = { "<cmd>lua require('crates').upgrade_crates()<CR>", "Upgrade crates" },
                                },
                            },
                        }, { mode = "v", prefix = "<leader>ll" })
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
                    -- Crates keymap.
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
                        }
                    }
                },
            },
            setup = {
                rust_analyzer = function(_, opts)
                    local rust_tools_opts = require("user.utils").opts("rust-tools.nvim")
                    require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
                    return true
                end,
            },
        },
    },
    -- Extend auto completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "Saecki/crates.nvim",
                event = { "BufRead Cargo.toml" },
                config = function()
                    require("crates").setup({
                        popup = {
                            autofocus = true,
                        },
                    })
                end,
            },
        },
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
                { name = "crates" },
            }))
        end,
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
