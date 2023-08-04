return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      init = function()
        load_textobjects = true
      end,
    },
    cmd = { "TSUpdateSync" },
    keys = {
        { "<c-space>", desc = "increment selection" },
        { "<bs", desc = "Decrement selection", mode = "x" },
    },
    opts = {
        ensure_installed = "all",
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        autopairs = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        diagnostics = {
            enable = true,
            show_on_dirs = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        }
    }
}
