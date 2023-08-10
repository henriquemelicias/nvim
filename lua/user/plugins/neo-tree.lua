local ICONS = require("user.configs.settings").ICONS
local Utils = require("user.utils")

return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	branch = "v3.x",
	dependencies = { "s1n7ax/nvim-window-picker" },
    -- stylua: ignore
	keys = {
		{ "<leader>bb", function() require("neo-tree.command").execute({ toggle = true, dir = Utils.get_root(), position = "right", source = "buffers", }) end, desc = "Neotree buffers" },
		{ "<leader>e", function() require("neo-tree.command").execute({ toggle = true, dir = Utils.get_root(), position = "right", source = "document_symbols", }) end, desc = "Neotree document symbols" },
		{ "<leader>gn", function() require("neo-tree.command").execute({ toggle = true, dir = Utils.get_root(), position = "left", source = "git_status", }) end, desc = "Neotree git status" },
		{ "<leader>q", function() require("neo-tree.command").execute({ toggle = true, dir = Utils.get_root(), position = "left" }) end, desc = "Neotree explorer" },
		{ "<M-S-Q>", function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), position = "left" }) end, desc = "Explorer NeoTree (cwd)" },
	},
	init = function()
		if vim.fn.argc() == 1 then
			local stat = vim.loop.fs_stat(vim.fn.argv(0))
			if stat and stat.type == "directory" then
				require("neo-tree")
			end
		end
	end,
	opts = {
		sources = { "filesystem", "buffers", "git_status", "document_symbols" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
		},
		window = {
			mappings = {
				["<space>"] = "none",
			},
		},
		event_handlers = {
			{
				event = "neo_tree_buffer_enter",
				handler = function(_)
					vim.cmd([[ setlocal relativenumber ]])
				end,
			},
		},
		document_symbols = {
			kinds = {
				File = { icon = ICONS.KINDS.File, hl = "Tag" },
				Namespace = { icon = ICONS.KINDS.Module, hl = "Include" },
				Package = { icon = ICONS.KINDS.Package, hl = "Label" },
				Class = { icon = ICONS.KINDS.Class, hl = "Include" },
				Property = { icon = ICONS.KINDS.Property, hl = "@property" },
				Enum = { icon = ICONS.KINDS.Enum, hl = "@number" },
				Function = { icon = ICONS.KINDS.Function, hl = "Function" },
				String = { icon = ICONS.KINDS.Text, hl = "String" },
				Number = { icon = ICONS.KINDS.Value, hl = "Number" },
				Array = { icon = ICONS.KINDS.Array, hl = "Type" },
				Object = { icon = ICONS.KINDS.Object, hl = "Type" },
				Key = { icon = ICONS.KINDS.Keyword, hl = "" },
				Struct = { icon = ICONS.KINDS.Struct, hl = "Type" },
				Operator = { icon = ICONS.KINDS.Operator, hl = "Operator" },
				TypeParameter = { icon = ICONS.KINDS.TypeParameter, hl = "Type" },
				StaticMethod = { icon = ICONS.KINDS.Method, hl = "Function" },
			},
		},

		default_component_configs = {
			container = {
				enable_character_fade = false,
			},
			indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = "",
				folder_open = "",
				folder_empty = "",
				folder_empty_open = "",
				default = "*",
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "[+]",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- Change type
					added = ICONS.GIT.Added, -- or "✚", but this is redundant info if you use git_status_colors on the name
					modified = ICONS.GIT.Modified, -- or "", but this is redundant info if you use git_status_colors on the name
					deleted = ICONS.GIT.Removed, -- this can only be used in the git_status source
					renamed = "", -- this can only be used in the git_status source
					-- Status type
					untracked = "",
					ignored = "",
					unstaged = "",
					staged = "",
					conflict = "",
				},
			},
		},
	},
}
