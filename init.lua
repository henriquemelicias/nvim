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
-- Lazy loaded plugins are configured on the "./lua/user/plugins.lua" file.
local plugins = "user.plugins."

require(plugins .. "impatient")       -- improve neovim startup time
require(plugins .. "alpha")           -- neovim greeter
require(plugins .. "bufferline")      -- tabs line above
require(plugins .. "colorscheme")     -- themes
require(plugins .. "lualine")         -- status line below
require(plugins .. "luasnip")         -- snippets
require(plugins .. "treesitter")
require(plugins .. "dap")             -- debugger
require(plugins .. "project")         -- projects detection

-- [ LANGUAGES ] --
local langs = "user.languages."

require(langs .. "rust")
-- [[ require("user.vimtex")           -- latex processor ]]


-- [ OTHER ] --
require(configs .. "highlights")       -- change highlights style

-- TODO: check multiple cursors in vim/neovim.
