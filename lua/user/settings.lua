-- GLOBAL SETTINGS/VARIABLES

--- LSP Servers.
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

-- DAP debuggers.
vim.api.nvim_set_var( "DAP_DEBUGGERS",
    {
        "codelldb"          -- C/C++/Rust/Swift
    }
)

-- TODO: Way or plugin to remove postspaces ? 

-- Files to open on an IDE-like environemtn.
vim.api.nvim_set_var( "IDE_FILE_PATTERNS",
    {
        "*.rs",
        "*.toml",
    }
)
