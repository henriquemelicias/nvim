return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = function()
		local npairs = require("nvim-autopairs")

		npairs.setup({
			check_ts = true,
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			disable_filetype = { "TelescopePrompt", "spectre_panel" },
			fast_wrap = {
				map = "<C-e>",
				chars = { "{", "[", "(", '"', "'", "<" },
				pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
				offset = 0, -- Offset from pattern match
				end_key = "e",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "PmenuSel",
				highlight_grey = "LineNr",
			},
		})

		-- Add spaces between parenthesis.
		local Rule = require("nvim-autopairs.rule")

		local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }
		npairs.add_rules({
			Rule(" ", " "):with_pair(function(opts)
				local pair = opts.line:sub(opts.col - 1, opts.col)
				return vim.tbl_contains({
					brackets[1][1] .. brackets[1][2],
					brackets[2][1] .. brackets[2][2],
					brackets[3][1] .. brackets[3][2],
				}, pair)
			end),
		})
		for _, bracket in pairs(brackets) do
			npairs.add_rules({
				Rule(bracket[1] .. " ", " " .. bracket[2])
					:with_pair(function()
						return false
					end)
					:with_move(function(opts)
						return opts.prev_char:match(".%" .. bracket[2]) ~= nil
					end)
					:use_key(bracket[2]),
			})
		end

		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
	end,
}
