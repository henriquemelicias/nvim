return -- Autocompletion
{
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				"hrsh7th/cmp-buffer",
				"FelipeLema/cmp-async-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-calc",
				"f3fora/cmp-spell",
				"saadparwaiz1/cmp_luasnip",
				"petertriho/cmp-git",
				"David-Kunz/cmp-npm",
				"hrsh7th/cmp-nvim-lsp-document-symbol",
				"hrsh7th/cmp-nvim-lsp-signature-help",
				"tamago324/cmp-zsh",
			},
		},
		config = function()
			require("lsp-zero").extend_cmp()

			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end

			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

			cmp.setup({
				completion = {
					completeopt = "menu,menuone,noinsert,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "crates" },
					{ name = "npm", keyword_length = 4 },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp_document_symbol" },
					{ name = "copilot", max_item_count = 4 },
					{ name = "luasnip", max_item_count = 10 },
					{ name = "calc" },
					{ name = "buffer", keyword_length = 4, max_item_count = 10 },
					{ name = "async_path" },
					{
						name = "spell",
						option = {
							keep_all_entries = false,
							enable_in_context = function()
								return true
							end,
						},
						keyword_length = 5,
						max_item_count = 3,
					},
				},
				window = {
					documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered(),
				},
				confirm_opts = {
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				},
				formatting = {
					fields = { "abbr", "kind", "menu" },
					format = function(entry, vim_item)
						vim_item.menu = ({
							crates = "[CRATES]",
							npm = "[NPM]",
							nvim_lsp = "[LSP]",
							nvim_lsp_document_symbol = "[LSP]",
							nvim_lsp_signature_help = "[LSP]",
							nvim_lua = "[LUA]",
							luasnip = "[LUASNIP]",
							git = "[GIT]",
							buffer = "[BUFFER]",
							async_path = "[PATH]",
							calc = "[CALC]",
							copilot = "[COPILOT]",
							spell = "[SPELL]",
							zsh = "[ZSH]",
						})[entry.source.name]

						return vim_item
					end,
				},
				experimental = {
					ghost_text = {
						hl_group = "CmpGhostText",
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
					["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
					["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
					["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
					["<C-a>"] = cmp.mapping({
						i = cmp.mapping.abort(),
						c = cmp.mapping.close(),
					}),
					-- Accept currently selected item. If none selected, `select` first item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
                sorting = require("cmp.config.default")().sorting,
			})
		end,
	},
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		event = "VeryLazy",
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})

			require("cmp").config.formatting = {
				format = require("tailwindcss-colorizer-cmp").formatter,
			}
		end,
		dependencies = "nvim-cmp",
	},
}
