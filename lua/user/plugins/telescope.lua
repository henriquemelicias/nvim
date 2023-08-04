return {
	-- Telescope main plugin.
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		event = "VeryLazy",
		config = function()
			local SETTINGS = require("user.configs.settings")
			local telescope = require("telescope")

			telescope.setup({
				defaults = {
					prompt_prefix = " ",
					selection_caret = " ",
					path_display = { "smart" },

					file_ignore_patterns = {
						".git/",
						"node_modules",
					},
				},
				extensions = {

					-- Faster sorting.
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					-- Find files by frequency algorithm.
					frecency = {
						show_scores = true,
						show_unindexed = true,
						ignore_patterns = { "*.git/*", "*/tmp/*" },
						disable_devicons = false,
						workspaces = SETTINGS.WORKSPACES_DIRS,
					},
					-- Find media files.
					media_files = {
						filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "pdf", "epub", "ttf" },
						find_cmd = "rg", -- find command (defaults to `fd`)
					},
					-- Switch between git repos.
					repo = {
						list = {
							fd_opts = {
								"--no-ignore-vcs",
							},
							search_dirs = SETTINGS.REPOS_DIRS,
						},
					},
					-- Custom menu.
					menu = {
						default = {
							items = {
								{ "Telescope builtins", "Telescope builtin" },
								{ "Telescope extensions", "Telescope menu telescope_extensions" },
								{ "Checkhealth", "checkhealth" },
								{ "Show LSP Info", "LspInfo" },
								{ "Change colorscheme", "Telescope colorscheme" },
							},
						},
						telescope_extensions = {
							items = {},
						},
					},
				},
			})

			telescope.load_extension("fzf")
			telescope.load_extension("frecency")
			telescope.load_extension("repo")
			telescope.load_extension("luasnip")
			telescope.load_extension("menu")
            telescope.load_extension("project")
			telescope.load_extension("harpoon")
		end,
		keys = function()
			local wk = require("which-key")

			wk.register({
				-- Telescope builtin.
				f = {
					name = "+telescope",
					b = { ":Telescope buffers<CR>", "Buffers" },
					f = { ":Telescope find_files<CR>", "Find files" },
					g = { ":Telescope live_grep<CR>", "Find with grep" },
					h = { ":Telescope help_tags<CR>", "Help tags" },
					m = { ":Telescope builtin<CR>", "Menu with builtin fns" },
					r = { ":Telescope git_files<CR>", "Search files in repo (git)" },
					o = { ":Telescope oldfiles<CR>", "Old files" },
                    s = { ":Telescope search_history<CR>", "Search history" },
                    c = { ":Telescope command_history<CR>", "Command history" }
				},
				-- Telescope extensions.
				F = {
					name = "+telescope_ext",
					c = { ":Telescope neoclip<CR>", "Clip manager" },
					d = { ":TodoTelescope<CR>", "See TODOs and other temporary tags" },
					f = { ":Telescope frecency<CR>", "Find files by frecency algorithm" },
					m = { ":Telescope menu<CR>", "Custom menu" },
					p = { ":Telescope project<CR>", "Projects"},
					r = { ":Telescope repo<CR>", "Switch between VCS repos" },
					s = { ":Telescope luasnip<CR>", "Lua snippets" },
					t = { ":Telescope telescope-tabs list_tabs<CR>", "Switch between tabs" },
				},
                -- Git
                g = {
                    f = { ":Telescope git_files<CR>", "Telescope find git files" },
                    s = { ":Telescope git_stash<CR>", "Telescope git stash" },
                    c = { ":Telescope git_commits<CR>", "Telescope git commits" },
                    b = { ":Telescope git_branches<CR>", "Telescope git branches" },
                }
			}, { mode = "n", prefix = "<leader>" })
		end,
	},
	-- Extensions go here.
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
	{ "nvim-telescope/telescope-frecency.nvim", dependencies = { "kkharji/sqlite.lua" }, lazy = true },
	{ "cljoly/telescope-repo.nvim", lazy = true },
	{ "benfowler/telescope-luasnip.nvim", lazy = true },
	{ "octarect/telescope-menu.nvim", lazy = true },
    { "nvim-telescope/telescope-project.nvim", lazy = true },
	{
		"LukasPietzschmann/telescope-tabs",
		lazy = true,
		config = function()
			require("telescope-tabs").setup({
				entry_formatter = function(tab_id, _, file_names, _)
					local entry_string = table.concat(file_names, ", ")
					return string.format("%d: %s", tab_id, entry_string)
				end,
				close_tab_shortcut_i = "<C-d>", -- if you're in insert mode
				close_tab_shortcut_n = "D", -- if you're in normal mode
			})
		end,
	},
}
