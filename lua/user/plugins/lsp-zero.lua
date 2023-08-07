return {
	-- LSP
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "dev-v3",
		lazy = true,
		config = false,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
		},
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
			local lsp = require("lsp-zero").preset()
			local wk = require("which-key")

			require("inlay-hints").setup({
				only_current_line = true,
				eol = {
					right_align = true,
				},
			})

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
						s = {
							"<cmd>lua vim.lsp.buf.signature_help()<CR>",
							"LSP signature info of symbol",
						},
						l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "LSP diagnostics in float window" },
					},
					["<leader>l"] = {
						name = "+lsp",
						a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action at position" },
						k = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
						R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename current symbol" },
						d = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "List definitions of symbol" },
						r = { "<cmd>lua vim.lsp.buf.references()<CR>", "List references of symbol" },
					},
					["["] = {
						d = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "LSP diagnostics go previous" },
					},
					["]"] = {
						d = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "LSP diagnostics go next" },
					},
					["<leader>pw"] = {
						name = "+workspace",
						a = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "LSP add workspace folder" },
						r = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "LSP remove workspace folder" },
						l = {
							"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
							"LSP list workspace folders",
						},
					},
				}, { mode = "n", buffer = bufnr })
			end)

			-- LSP formatting --
			lsp.format_mapping("<leader>lf", {
				format_opts = {
					async = false,
					timeout_ms = 10000,
				},
				servers = {
					["null-ls"] = {
						"css",
						"graphql",
						"html",
						"javascript",
						"javascriptreact",
						"json",
						"less",
						"lua",
						"markdown",
						"scss",
						"sh",
						"svelte",
						"typescript",
						"typescriptreact",
						"vue",
						"yaml",
					},
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
					lua_ls = require("user.languages.lua").handler(lsp),
					rust_analyzer = require("user.languages.rust").handler(),
					tsserver = require("user.languages.typescript").handler(),
					tailwindcss = require("user.languages.tailwindcss").handler(lsp),
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
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.stylua.with({
						filetypes = {
							"lua",
						},
					}),
					null_ls.builtins.formatting.sqlformat,
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
}
