-- [ GENERAL ] --
local configs = "user."

require(configs .. "options")         -- general options
require(configs .. "plugins")         -- plugins management
require(configs .. "keymaps")         -- general keymaps
require(configs .. "autocmds")        -- autocommands on entering/exiting files, buffers, etc...

-- [ LSP, DAP, LINTERS AND FORMATTERS ] --
-- Check :Mason for all possible options.

vim.api.nvim_set_var( "LSP_SERVERS",
    {
        "angularls",        -- Angular
        "bashls",           -- Bash
        "clangd",           -- C/C++
        "csharp_ls",        -- C#
        "cmake",            -- CMake
        "cssls",            -- CSS
        "dockerls",         -- Docker
        "eslint",           -- ESlint
        "golangci_lint_ls", -- Go
        "html",             -- HTML
        "ltex",             -- LaTeX
        "sumneko_lua",      -- Lua
        "tsserver",         -- Javascript
        "jsonls",           -- Json
        "marksman",         -- Markdown
        "pyright",          -- Python
        "pylsp",            -- Python (docs)
        "rust_analyzer",    -- Rust
        "sqlls",            -- SQL
        "taplo",            -- TOML
        "tailwindcss",      -- Tailwind CSS
        "lemminx",          -- XML
        "yamlls",           -- Yaml
    }
)

-- DAP debuggers installed.
vim.api.nvim_set_var( "DAP_DEBUGGERS",
    {
        "codelldb"          -- C/C++/Rust/Swift
    }
)

-- Import Mason and LSP for the packages above.
require(configs .. "mason")           -- package management
require(configs .. "lsp")             -- language server protocol

-- [ PLUGINS ] --
local plugins = "user.plugins."

require(plugins .. "impatient")       -- improve neovim startup time
require(plugins .. "cmp")
require(plugins .. "dap")             -- debugger
require(plugins .. "alpha")           -- neovim greeter
require(plugins .. "colorscheme")     -- themes
require(plugins .. "telescope")       -- investigate submenus
require(plugins .. "gitsigns")        -- git signs decorations
require(plugins .. "treesitter")      -- parser generator tool for concrete syntax tree of a source file
require(plugins .. "comment")         -- quick block commend/uncomment with (gcc or gc{motion})
require(plugins .. "nvim-tree")       -- directory tree viewer
require(plugins .. "bufferline")      -- tabs line above
require(plugins .. "lualine")         -- status line below
require(plugins .. "tagbar")          -- tagbar menu on the right
require(plugins .. "toggleterm")      -- toggles the terminal window
require(plugins .. "project")         -- create/manage projects
require(plugins .. "illuminate")      -- highlights the same word across the file
require(plugins .. "blankline")       -- identation guides to all lines
require(plugins .. "marks")           -- create/jump to marks/bookmarks
require(plugins .. "colorize")        -- highlighter for colour codes
require(plugins .. "luasnip")         -- snippets
require(plugins .. "todo-comments")   -- temporary comment tags functionalities

-- [ LANGUAGES ] --
local langs = "user.languages."

require(langs .. "rust")
-- [[ require("user.vimtex")           -- latex processor ]]
