return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "mason.nvim" },
	opts = function()
		local null_ls = require("null-ls")
		return {
			root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
			debug = true,
            -- stylua: ignore
			sources = {
				null_ls.builtins.formatting.prettier.with({
					filetypes = { "css", "graphql", "html", "javascript", "javascriptreact", "json", "less", "markdown", "scss", "typescript", "typescriptreact", "yaml", },
				}),
				null_ls.builtins.formatting.stylua.with({
					filetypes = { "lua", },
				}),
				null_ls.builtins.formatting.sqlformat,

				null_ls.builtins.diagnostics.eslint.with({
					filetypes = { "css", "scss", },
				}),
			},
		}
	end,
}
