return {
	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "dev-v3",
		lazy = true,
		config = false,
	},
	-- null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		lazy = true,
		config = false,
	},
	-- INLAY HINTS
	{
		"simrat39/inlay-hints.nvim",
		lazy = true,
	},
	-- MASON
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		lazy = true,
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "hrsh7th/cmp-nvim-lsp" },
		},
		config = function()
			-- This is where all the LSP shenanigans will live
			local ih = require("inlay-hints")
			ih.setup()

			local lsp = require("lsp-zero").preset()
			local wk = require("which-key")

			lsp.on_attach(function(client, bufnr)
				-- Navic
				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, bufnr)
				end

				wk.register({
					K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "LSP display highlighted symbol info" },
					g = {
						name = "+Go To",
						d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "LSP jump to definition of symbol" },
						D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "LSP jump to symbol declaration" },
						i = {
							"<cmd>lua vim.lsp.buf.implementation()<CR>",
							"LSP list implementations of symbol",
						},
						o = {
							"<cmd>lua vim.lsp.buf.type_definition()<CR>",
							"LSP jump to definition of symbol",
						},
						r = { "<cmd>lua vim.lsp.buf.references()<CR>", "LSP list references of symbol" },
						s = {
							"<cmd>lua vim.lsp.buf.signature_help()<CR>",
							"LSP signature info of symbol",
						},
						l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "LSP diagnostics in float window" },
					},
					["<F2>"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "LSP rename current symbol" },
					["<F4>"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "LSP code action at position" },
					["["] = {
						d = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "LSP diagnostics go previous" },
					},
					["]"] = {
						d = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "LSP diagnostics go next" },
					},
				}, { mode = "n", buffer = bufnr })
			end)

			-- LSP formatting --
			lsp.format_mapping("<F3>", {
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					["null-ls"] = { "javascript", "typescript", "lua" },
				},
			})

			-- INSTALL DEBUGGERS DAP --
			local mason_reg = require("mason-registry")

			for _, debugger in pairs(require("user.configs.settings").DAP_DEBUGGERS) do
				if not mason_reg.is_installed(debugger) then
					vim.cmd("MasonInstall " .. debugger)
				end
			end

			-- SETUP LANGUAGES --
			require("mason-lspconfig").setup({
				ensure_installed = require("user.configs.settings").LSP_SERVERS,
				handlers = {
					lsp.default_setup,
					lua_ls = require("user.languages.lua").lua_ls_handler(lsp),
					rust_analyzer = require("user.languages.rust").rust_analyzer_handler(),
					tsserver = require("user.languages.typescript").tsserver_handler(),
				},
			})

			-- NULL LS --
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettier.with({
						filetypes = {
							"css",
							"graphql",
							"html",
							"javascript",
							"javascriptreact",
							"json",
							"less",
							"markdown",
							"scss",
							"typescript",
							"typescriptreact",
							"yaml",
						},
					}),
					null_ls.builtins.formatting.stylua.with({
						filetypes = {
							"lua",
						},
					}),
					null_ls.builtins.diagnostics.eslint.with({
						filetypes = {
							"css",
							"scss",
						},
					}),
				},
			})
		end,
	},
	-- LANGUAGE PLUGINS --
	-- RUST TOOLS
	{
		"simrat39/rust-tools.nvim",
		lazy = true,
	},
	-- Typescript
	{
		"jose-elias-alvarez/typescript.nvim",
		lazy = true,
	},
}
