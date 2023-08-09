return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		delay = 200,
		large_file_cutoff = 2000,
		large_file_overrides = {
			providers = { "lsp", "treesitter", "regex" },
		},
		under_cursor = true,
		filetypes_denylist = {
			"dirvish",
			"fugitive",
			"alpha",
			"NvimTree",
			"nerdtree",
			"packer",
			"neogitstatus",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"TelescopePrompt",
		},
	},
	config = function(_, opts)
        vim.cmd("hi IlluminatedWordRead guibg=#424040")
        vim.cmd("hi IlluminatedWordText guibg=#424040")
        vim.cmd("hi IlluminatedWordWrite guibg=#424040")

		require("illuminate").configure(opts)


		local function map(key, dir, buffer)
			vim.keymap.set("n", key, function()
				require("illuminate")["goto_" .. dir .. "_reference"](false)
			end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
		end

		map("]]", "next")
		map("[[", "prev")

		-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
		vim.api.nvim_create_autocmd("FileType", {
			callback = function()
				local buffer = vim.api.nvim_get_current_buf()
				map("]]", "next", buffer)
				map("[[", "prev", buffer)
			end,
		})
	end,
	keys = {
		{ "]]", desc = "Next reference" },
		{ "[[", desc = "Previous reference" },
	},
}
