local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    vim.notify("ERROR: Plugin telescope failed to load")
    return
end

-- Telescope setup.
local actions = require "telescope.actions"

telescope.setup {
    defaults = {

        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },

        file_ignore_patterns = {
            ".git/",
            "node_modules"
        },

        mappings = {
             i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,

                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,

                ["<C-c>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        },
    },


    extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure

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
            ignore_patterns = {"*.git/*", "*/tmp/*"},
            disable_devicons = false,
            workspaces = {
                ["home"]            = vim.env.HOME,
                ["home-config"]     = vim.env.HOME .. "/.config",
                ["home-data"]       = vim.env.HOME .. "/.local/share",
                ["home-projects"]   = vim.env.HOME .. "/Programming/Projects",
                ["home-challenges"] = vim.env.HOME .. "/Programming/Challenges",
                ["home-study"]      = vim.env.HOME .. "/Study",
                ["home-runnables"]  = vim.env.HOME .. "/Runnables",
                ["home-temporary"]  = vim.env.HOME .. "/Temporary",
                ["home-other"]      = vim.env.HOME .. "/Other"
            }
        },
        -- Find media files.
        -- TODO: check if it works on x11 and if its simply a wayland problem
        media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg", "mp4", "pdf", "epub", "ttf"},
            find_cmd = "rg" -- find command (defaults to `fd`)
        },
        -- Telescope-repo: switch between git repos.
        repo = {
            list = {
                fd_opts = {
                    "--no-ignore-vcs",
                },
                search_dirs = {
                    vim.env.HOME .. "/Study",
                    vim.env.HOME .. "/Programming",
                },
            },
        },
        menu = {
            default = {
                items = {
                    { "Telescope builtins", "Telescope builtin" },
                    { "Telescope extensions", "Telescope menu telescope_extensions"  },
                    { "Checkhealth", "checkhealth" },
                    { "Show LSP Info", "LspInfo" },
                    { "Change colorscheme", "Telescope colorscheme" },
                },
            },
            telescope_extensions = {
                items = {

                }
            }
        },
    },
}

require'telescope-tabs'.setup{
    entry_formatter = function(tab_id, buffer_ids, file_names, file_paths)
        local entry_string = table.concat(file_names, ', ')
        return string.format('%d: %s', tab_id, entry_string)
    end,
    close_tab_shortcut_i = '<C-d>',-- if you're in insert mode
    close_tab_shortcut_n = 'D',    -- if you're in normal mode
}

-- Load extensions.
telescope.load_extension("fzf")
telescope.load_extension("frecency")
telescope.load_extension("media_files")
telescope.load_extension("repo")
telescope.load_extension('luasnip')
telescope.load_extension("menu")

-- Plugin projects must be loaded first.
telescope.load_extension("projects")
