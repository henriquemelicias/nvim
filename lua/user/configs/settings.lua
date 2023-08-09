M = {}

-- DIRECTORIES --
M.BACKUP_DIR = (os.getenv("XDG_STATE_HOME") or "../..") .. "/nvim/backup"

-- WORKSPACES --
-- Used by the telescope find by frecency algorithm.
M.WORKSPACES_DIRS = {
    --["home"]            = vim.env.HOME,
    --["home-config"]     = vim.env.HOME .. "/.config",
    --["home-data"]       = vim.env.HOME .. "/.local/share",
    --["home-projects"]   = vim.env.HOME .. "/Programming/Projects",
    --["home-challenges"] = vim.env.HOME .. "/Programming/Challenges",
    --["home-study"]      = vim.env.HOME .. "/Study",
    --["home-runnables"]  = vim.env.HOME .. "/Runnables",
    --["home-temporary"]  = vim.env.HOME .. "/Temporary",
    --["home-other"]      = vim.env.HOME .. "/Other"
}

-- REPOS --
-- Used by telescope-repo to find git repositories.
M.REPOS_DIRS = {
    vim.env.HOME,
}

-- This is only for languages that still do not have a language config lua file in "user.configs.languages"
M.MASON_ENSURE_INSTALLED = {
-- LSP SERVERS --
    "asm-lsp",                          -- Assembly
    "buf-language-server",              -- Protobuf
    "clangd",                           -- C/C++
    "clojure-lsp",                      -- Clojure
    "cmake-language-server",            -- CMake
    "csharp-language-server",           -- C#
    "css-lsp",                          -- CSS
    "cssmodules-language-server",       -- CSS Modules
    "dockerfile-language-server",       -- Docker
    "docker-compose-language-service",  -- Docker Compose
    "eslint-lsp",                       -- ESlint
    "gopls",                            -- Go
    "gradle-language-server",           -- Gradle
    "graphql-language-service-cli",     -- GraphQL
    "haskell-language-server",          -- Haskell
    "html-lsp",                         -- HTML
    "jdtls",                            -- Java
    "json-lsp",                         -- Json
    "kotlin-language-server",           -- Kotlin
    "lua-language-server",              -- Lua
    "marksman",                         -- Markdown
    "nginx-language-server",            -- Nginx
    "ocaml-lsp",                        -- OCaml
    "pkgbuild-language-server",         -- Pkgbuild
    "pyright",                          -- Python
    "sqlls",                            -- SQL
    "svelte-language-server",           -- Svelte
    "tailwindcss-language-server",      -- Tailwind CSS
    "taplo",                            -- TOML
    "texlab",                           -- LaTeX
    "typescript-language-server",       -- Typescript/JavaScript
    "lemminx",                          -- XML
    "yaml-language-server",             -- Yaml
    "zls",                              -- Zig

-- DAP DEBUGGERS --
    "debugpy",                          -- Python
    "go-debug-adapter",                 -- Go
    "java-debug-adapter",               -- Java
    "js-debug-adapter",                 -- Javascript
    "kotlin-debug-adapter",             -- Kotlin
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
        Stopped = { " ", "DiagnosticWarn", "DapStoppedLine" },
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
