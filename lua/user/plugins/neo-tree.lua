local ICONS = require( "user.configs.settings" ).ICONS
local root_patterns = { ".git", "lua" }
-- Return the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@return string
local function get_root()
    ---@type string?
    local path = vim.api.nvim_buf_get_name(0)
    path = path ~= "" and vim.loop.fs_realpath(path) or nil
    ---@type string[]
    local roots = {}
    if path then
        for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
            local workspace = client.config.workspace_folders
            local paths = workspace and vim.tbl_map(function(ws)
                return vim.uri_to_fname(ws.uri)
            end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
            for _, p in ipairs(paths) do
                local r = vim.loop.fs_realpath(p)
                if path:find(r, 1, true) then
                    roots[#roots + 1] = r
                end
            end
        end
    end
    table.sort(roots, function(a, b)
        return #a > #b
    end)
    ---@type string?
    local root = roots[1]
    if not root then
        path = path and vim.fs.dirname(path) or vim.loop.cwd()
        ---@type string?
        root = vim.fs.find(root_patterns, { path = path, upward = true })[1]
        root = root and vim.fs.dirname(root) or vim.loop.cwd()
    end
    ---@cast root string
    return root
end

return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    branch = "v3.x",
    dependencies = { "s1n7ax/nvim-window-picker" },
    keys = {
        {
            "<leader>bb",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = get_root(), position = "right", source = "buffers" })
            end,
            desc = "Neotree buffers"
        },
        {
            "<leader>e",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = get_root(), position = "right", source = "document_symbols" })
            end,
            desc = "Neotree document symbols"
        },
        {
            "<leader>gg",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = get_root(), position = "left", source = "git_status" })
            end,
            desc = "Neotree git status"
        },
        {
            "<leader>q",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = get_root(), position = "left" })
            end,
            desc = "Neotree explorer",
        },
        {
            "<M-S-Q>",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), position = "left"})
            end,
            desc = "Explorer NeoTree (cwd)",
        },
    },
    deactivate = function()
        vim.cmd([[Neotree position=left close]])
        vim.cmd([[Neotree position=right close]])
    end,
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
                    vim.cmd [[
                    setlocal relativenumber
                    ]]
                end,
            },
        },
        document_symbols = { kinds = {
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
            StaticMethod = { icon = ICONS.KINDS.Method, hl = 'Function' }
        } },


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
    }
}
