return -- Autocompletion
{
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		{ "L3MON4D3/LuaSnip" },
	},
	config = function()
		-- Here is where you configure the autocompletion settings.
		require("lsp-zero").extend_cmp()

		-- And you can configure cmp even more, if you want to.
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local check_backspace = function()
			local col = vim.fn.col(".") - 1
			return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
		end

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			sources = {
				{ name = "crates", group_index = 1 },
				{ name = "npm", group_index = 1, keyword_length = 4 },
				{ name = "nvim_lsp", group_index = 2 },
				{ name = "nvim_lsp_signature_help", group_index = 2 },
				{ name = "nvim_lua", group_index = 2 },
				{ name = "luasnip", group_index = 2 },
				{ name = "treesitter", group_index = 2 },
				{ name = "copilot", group_index = 2, max_item_count = 4 },
				{ name = "buffer", group_index = 2, keyword_length = 4 },
				{ name = "path", group_index = 2 },
				{ name = "calc", group_index = 2 },
				{ name = "emoji", group_index = 2 },
				{
					name = "spell",
					option = {
						keep_all_entries = false,
						enable_in_context = function()
							return true
						end,
					},
					group_index = 2,
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
				fields = { "menu", "abbr", "kind" },
				format = function(entry, vim_item)
					-- Kind icons

					-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
					vim_item.menu = ({
						crates = "[Crates]",
						npm = "[NPM]",
						nvim_lsp = "[LSP]",
						nvim_lsp_document_symbol = "[LSP]",
						nvim_lsp_signature_help = "[LSP]",
						nvim_lua = "[Lua]",
						luasnip = "[Luasnip]",
						git = "[Git]",
						buffer = "[Buffer]",
						treesitter = "[Tree]",
						path = "[Path]",
						calc = "[Calc]",
						copilot = "[Copilot]",
						spell = "[Spell]",
						emoji = "[Emoji]",
						zsh = "[ZSH]",
					})[entry.source.name]

					return vim_item
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(),
				["<C-j>"] = cmp.mapping.select_next_item(),
				["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
				["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
				["<m-o"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
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
					if luasnip.expandable() then
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
		})
	end,
}
