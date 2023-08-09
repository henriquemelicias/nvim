return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "mason.nvim" },
	opts = function()
		local null_ls = require("null-ls")
		local formats_dir = vim.fn.stdpath("config") .. "/lua/user/formats/"

		return {
			root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
			debug = true,
            -- stylua: ignore
			sources = {
                -- [ C/C++ ] --
                null_ls.builtins.formatting.clang_format.with({
                    filetypes = { "c", "cpp", "cs", "java", "cuda", "proto", },
                    extra_args = { "--style", "file:" .. formats_dir .. "custom.clang-format" },
                }),
                null_ls.builtins.diagnostics.clang_check,

                -- [ Shell ] --
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

				null_ls.builtins.formatting.prettier.with({
					filetypes = { "css", "graphql", "html", "javascript", "javascriptreact", "json", "less", "markdown", "scss", "typescript", "typescriptreact", "yaml", },
				}),
				null_ls.builtins.formatting.stylua.with({
					filetypes = { "lua", },
				}),
				null_ls.builtins.formatting.sqlformat,

                -- [ RUST ] --
				null_ls.builtins.formatting.rustfmt.with({
					filetypes = { "rust", },
					command = formats_dir .. "rustfmt",
					extra_args = { "--edition", "2021", "--config-path", formats_dir .. "rustfmt.toml" },
				}),
				null_ls.builtins.formatting.rustywind.with({
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "html", "rust" },
                    command = "rustywind"
				}),

				null_ls.builtins.diagnostics.eslint.with({
					filetypes = { "css", "scss", },
				}),
			},
		}
	end,
}
