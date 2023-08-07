M = {}

-- DIRECTORIES --
M.BACKUP_DIR = (os.getenv("XDG_STATE_HOME") or "../..") .. "/nvim/backup"

-- WORKSPACES --
-- Used by the telescope find by frecency algorithm.
M.WORKSPACES_DIRS = {
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

-- REPOS --
-- Used by telescope-repo to find git repositories.
M.REPOS_DIRS = {
    vim.env.HOME,
}

-- LSP SERVERS --
M.LSP_SERVERS = {
    "bashls",                           -- Bash
    "clangd",                           -- C/C++
    "cmake",                            -- CMake
    "csharp_ls",                        -- C#
    "cssls",                            -- CSS
    "dockerls",                         -- Docker
    "docker_compose_language_service",  -- Docker Compose
    "eslint",                           -- ESlint
    "golangci_lint_ls",                 -- Go
--    "html",                             -- HTML
    "ltex",                             -- LaTeX
    "lua_ls",                           -- Lua
    "kotlin_language_server",           -- Kotlin
    "tsserver",                         -- Javascript
    "jdtls",                            -- Java
    "jsonls",                           -- Json
    "marksman",                         -- Markdown
    "pyright",                          -- Python
    "pylsp",                            -- Python (docs)
--    "rust_analyzer",                    -- Rust
    "sqlls",                            -- SQL
    "svelte",                           -- Svelte
    "taplo",                            -- TOML
 --   "tailwindcss",                      -- Tailwind CSS
    "lemminx",                          -- XML
    "yamlls",                           -- Yaml
}

-- DAP DEBUGGERS --
M.DAP_DEBUGGERS = {
    "codelldb",                         -- C/C++/Rust/Swift
    "bash-debug-adapter",               -- Bash
--    "debugpy",                          -- Python
}

-- Files to open on an IDE-like environment.
M.IDE_FILE_PATTERNS = {
    "*.rs",
    "*.toml",
}

-- Files to open with spell check and wrap on.
M.SPELL_FILE_PATTERNS = {
    "txt",
    "markdown",
    "gitcommit",
}

M.ICONS = {
    DAP = {
        Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
        Breakpoint = " ",
        BreakpointCondition = " ",
        BreakpointRejected = { " ", "DiagnosticError" },
        LogPoint = ".>",
    },
    DIAGNOSTICS = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " ",
    },
    GIT = {
        Added = " ",
        Modified = " ",
        Removed = " ",
        Branch = "",
    },
    KINDS = {
        Array = " ",
        Boolean = " ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Copilot = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = "ƒ ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = "Պ ",
        Module = " ",
        Namespace = " ",
        Null = " ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
    },
}

return M
