local M = {}

function M.handler(lsp)

	require("lspconfig").tailwindcss.setup({
		settings = {
			tailwindcss = {
				filetypes_exclude = { "marksdown" },
			},
		},
	})

	lsp.configure("tailwindcss", {
		filetypes = {
			"aspnetcorerazor",
			"astro",
			"astro-markdown",
			"blade",
			"clojure",
			"django-html",
			"htmldjango",
			"edge",
			"eelixir",
			"elixir",
			"ejs",
			"erb",
			"eruby",
			"gohtml",
			"haml",
			"handlebars",
			"hbs",
			"html",
			"html-eex",
			"heex",
			"jade",
			"leaf",
			"liquid",
			"markdown",
			"mdx",
			"mustache",
			"njk",
			"nunjucks",
			"php",
			"razor",
			"rust",
			"slim",
			"twig",
			"css",
			"less",
			"postcss",
			"sass",
			"scss",
			"stylus",
			"sugarss",
			"javascript",
			"javascriptreact",
			"reason",
			"rescript",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
	})
end

return M
