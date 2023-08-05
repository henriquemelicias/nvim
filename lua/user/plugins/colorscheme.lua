-- Theme used.
return {
	"sainnhe/gruvbox-material",
	lazy = false,
	priority = 1000,
	config = function()
		-- Options here. See :help gruvbox-material.txt
		local opts = {
			background = "medium",
			foreground = "mix",
			enable_bold = 1,
			enable_italic = 1,
			transparent_background = 0,
			dim_inactive_windows = 1,
			spell_foreground = "none",
			ui_contrast = "high",
			text_highlight = 1,
			error_highlight = 1,
			diagnostic_text_highlight = 1,
			diagnostic_line_highlight = 1,
			diagnostic_virtual_text = "highlight",
			current_word = "bold",
			statusline_style = "mix",
		}

		for key, value in pairs(opts) do
			vim.g["gruvbox_material_" .. key] = value
		end

		-- Start.
		vim.cmd([[colorscheme gruvbox-material]])
	end,
}
