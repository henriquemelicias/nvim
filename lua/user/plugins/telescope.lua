return {
	-- Telescope main plugin.
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		cmd = "Telescope",
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
			telescope.load_extension("neoclip")
			telescope.load_extension("frecency")
			telescope.load_extension("repo")
			telescope.load_extension("luasnip")
			telescope.load_extension("menu")
			telescope.load_extension("project")
			telescope.load_extension("harpoon")
		end,
		keys = function()
			local wk = require("which-key")

            -- stylua: ignore
			wk.register({
				-- Telescope builtin.
				f = {
					name = "+telescope",
					b = { ":Telescope buffers show_all_buffers=true<CR>", "Buffers" },
					B = { ":Telescope builtin<CR>", "Builtins telescope menu" },
					c = { ":Telescope command_history<CR>", "Command history" },
					C = { ":Telescope commands<CR>", "Commands" },
					d = { ":Telescope diagnostics bufnr=0<CR>", "Diagnostics of this buffer" },
					D = { ":Telescope diagnostics<CR>", "Diagnostics of workspace" },
					f = { ":Telescope find_files<CR>", "Find files (root dir)" },
					F = { ":lua require('telescope.builtin').find_files( { cwd = vim.fn.expand('%:p:h') })<CR>", "Find files (cwd)" },
					g = { ":Telescope live_grep<CR>", "Find with grep (root dir)" },
					G = { ":lua require('telescope.builtin').live_grep( { cwd = vim.fn.expand('%:p:h') })<CR>", "Find with grep (cwd)" },
					h = { ":Telescope help_tags<CR>", "Help tags" },
					H = { ":Telescope highlights<CR>", "Highlights" },
					l = { ":Telescope lsp_document_symbols<CR>", "LSP symbols goto (buffer)" },
					L = { ":Telescope lsp_dynamic_workspace_symbols<CR>", "LSP symbols goto (workspace)" },
					k = { ":Telescope keymaps<CR>", "Keymaps" },
					m = { ":Telescope man_pages<CR>", "Man pages" },
					M = { ":Telescope marks<CR>", "Marks" },
					o = { ":Telescope oldfiles<CR>", "Recent files" },
					O = { ":lua require('telescope.builtin').oldfiles( { cwd = vim.fn.expand( '%:p:h' ) } )<CR>", "Recent files (cwd)" },
					r = { ":Telescope resume<CR>", "Resume previous search" },
					s = { ":Telescope current_buffer_fuzzy_find<CR>", "Find in current buffer" },
					S = { ":Telescope search_history<CR>", "Search history" },
				},
				-- Telescope extensions.
				F = {
					name = "+telescope_ext",
					c = { ":Telescope neoclip<CR>", "Clip manager" },
					d = { ":TodoTelescope<CR>", "See TODOs and other temporary tags" },
					f = { ":Telescope frecency<CR>", "Find files by frecency algorithm" },
					m = { ":Telescope menu<CR>", "Custom menu" },
					n = { ":lua require('telescope').extensions.notify.notify()<CR>", "Notify messages" },
					p = { ":Telescope project<CR>", "Projects" },
					r = { ":Telescope repo list<CR>", "Switch between VCS repos" },
					R = { ":lua require'telescope'.extensions.repo.list{search_dirs = {vim.fn.input('Directory to search: ')}}<CR>", "Switch between VCS repos in dirs..." },
					s = { ":Telescope luasnip<CR>", "Lua snippets" },
					t = { ":Telescope telescope-tabs list_tabs<CR>", "Switch between tabs" },
				},
				-- Git
				g = {
					b = { ":Telescope git_branches<CR>", "Telescope git branches" },
					c = { ":Telescope git_commits<CR>", "Telescope git commits" },
					f = { ":Telescope git_files<CR>", "Telescope find files in git repo" },
					s = { ":Telescope git_status<CR>", "Telescope git status" },
					S = { ":Telescope git_stash<CR>", "Telescope git stash" },
				},
				-- Harpoon
				h = {
					m = { ":Telescope harpoon marks<CR>", "Telescope harpoon menu" },
				},
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
		"AckslD/nvim-neoclip.lua",
		lazy = true,
		dependencies = { "kkharji/sqlite.lua" },
		config = function()
			require("neoclip").setup({
				enable_persistent_history = true,
				default_register = { '"', "+", "*" },
				keys = {
					telescope = {
						i = {
							paste = "<cr>",
							paste_behind = "<c-k>",
							replay = "<c-q>", -- replay a macro
							delete = "<c-d>", -- delete an entry
							edit = "<c-e>", -- edit an entry
							custom = {},
						},
						n = {
							select = "<nop>",
							paste = { "<cr>", "p" },
							--- It is possible to map to more than one key.
							-- paste = { 'p', '<c-p>' },
							paste_behind = "P",
							replay = "q",
							delete = "d",
							edit = "e",
							custom = {},
						},
					},
					fzf = {
						select = "default",
						paste = "<cr>",
						paste_behind = "<nop>",
						custom = {},
					},
				},
			})
		end,
	},
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
