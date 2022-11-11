-- [ GENERAL ] --
local configs = "user."

require(configs .. 'settings')	      -- user defined global setings/variables
require(configs .. "vim_options")     -- general vim options
require(configs .. "plugins")         -- plugins management
require(configs .. "keymaps")         -- general keymaps
require(configs .. "autocmds")        -- autocommands on entering/exiting files, buffers, etc...

-- [ IDE PLUGINS ] -- 
require(configs .. "mason")           -- package management
require(configs .. "lsp")             -- language server protocol

-- [ PLUGINS ] --
local plugins = "user.plugins."

require(plugins .. "impatient")       -- improve neovim startup time
require(plugins .. "alpha")           -- neovim greeter
require(plugins .. "luasnip")         -- snippets
require(plugins .. "dap")             -- debugger
require(plugins .. "colorscheme")     -- themes
require(plugins .. "gitsigns")        -- git signs decorations
require(plugins .. "treesitter")      -- parser generator tool for concrete syntax tree of a source file
require(plugins .. "nvim-tree")       -- directory tree viewer
require(plugins .. "bufferline")      -- tabs line above
require(plugins .. "lualine")         -- status line below
require(plugins .. "toggleterm")      -- toggles the terminal window
require(plugins .. "project")         -- create/manage projects

-- [ LANGUAGES ] --
local langs = "user.languages."

require(langs .. "rust")
-- [[ require("user.vimtex")           -- latex processor ]]


