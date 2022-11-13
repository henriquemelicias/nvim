local fn = vim.fn

-- Automatically install packer.
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file.
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

-- Use a protected call so we don't error out on first use.
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window.
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Plugins Lazy Load Directory: plugins which are lazy loaded go to this directory.
G_PlugLL_Dir = "user.plugins_lazyload."

-- Install your plugins here.
return packer.startup(function(use)

    -- General plugins.
    use "wbthomason/packer.nvim"                            -- have packer manage itself
    use "nvim-lua/plenary.nvim"                             -- useful lua functions used ny lots of plugins

    use {
        "nvim-lua/popup.nvim",                              -- an implementation of the Popup API from vim in Neovim
        after = "plenary.nvim"
    }
    use {
        "windwp/nvim-autopairs",                            -- close brackets etc.
        after = "nvim-cmp",
        config = function ()
            require(G_PlugLL_Dir .. "autopairs")
        end
    }
    use {
        "numToStr/Comment.nvim",                            -- comment support
        event = "CursorMoved",
        config = function()
            require(G_PlugLL_Dir .. "comment")
        end
    }
    use {
        "lukas-reineke/indent-blankline.nvim",              -- indent lines customization
        event = "BufWinEnter",
        config = function()
            require(G_PlugLL_Dir .. "blankline")
        end
    }
    use {
        "chentoast/marks.nvim",                             -- better marks functionalities
        event = "VimEnter",
        config = function()
            require(G_PlugLL_Dir .. "marks")
        end
    }
    use {
        "norcalli/nvim-colorizer.lua",                      -- highlights color codes in the file itself
        event = "BufWinEnter",
        config = function()
            require(G_PlugLL_Dir .. "colorizer")
        end
    }
    use {
        "tpope/vim-surround",                               -- manage surrounding symbols with ease (parenthesis, brakets, ... )
        event = "CursorMoved",
    }
    use "lewis6991/impatient.nvim"                          -- improves neovim startup times
    use {
        "ahmedkhalf/project.nvim",                           -- project manager
    }
    use {
        "akinsho/toggleterm.nvim",                           -- terminal toggler
        event = "VimEnter",
        config = function()
            require(G_PlugLL_Dir .. "toggleterm")
        end
    }
    use {
        "folke/todo-comments.nvim",                         -- temporary comment tags functionalities
        event = "BufWinEnter",
        config = function()
            require(G_PlugLL_Dir .. "todo-comments")
        end
    }
    use {
        "xiyaowong/link-visitor.nvim",
        event = "BufWinEnter",
        config = function()
            require(G_PlugLL_Dir .. "link-visitor")
        end
    }

    -- Layout.
    use "goolord/alpha-nvim"                                -- neovim greeter page
    use 'nvim-lualine/lualine.nvim'                         -- status line on the bottom
    use "akinsho/bufferline.nvim"                           -- tabs/buffers statusline on top
    use {
        "majutsushi/tagbar",                                 -- window for all classes, methods and variables
        event = "VimEnter",
        config = function ()
            require(G_PlugLL_Dir .. "tagbar")
        end
    }

    -- Colorschemes
    use "ellisonleao/gruvbox.nvim"

    -- CMP & plugins.
    use {
        "hrsh7th/nvim-cmp",                                 -- the completion plugin
        event = "InsertEnter",
        config = function()
            require(G_PlugLL_Dir .. "cmp")
        end
    }
    use {
	    "hrsh7th/cmp-buffer",                               -- buffer completions
        after = "nvim-cmp"
    }
    use {
	    "hrsh7th/cmp-path",                                 -- path completions
        after = "nvim-cmp"
    }
    use {
	    "hrsh7th/cmp-cmdline",                              -- cmdline completions
        after = "nvim-cmp"
    }
    use {
	    "hrsh7th/cmp-calc",                                 -- math calculations completion
        after = "nvim-cmp"
    }
    use {
	    "hrsh7th/cmp-nvim-lua",                             -- lua specific completions
        after = "nvim-cmp"
    }
    use {
	    "hrsh7th/cmp-emoji",                                -- emoji completios
        after = "nvim-cmp"
    }
    use {
	    "f3fora/cmp-spell",                                 -- spelling completions
        after = "nvim-cmp"
    }
    use {
	    "saadparwaiz1/cmp_luasnip",                         -- snippet completions
        after = "nvim-cmp"
    }
    use {
	    "ray-x/cmp-treesitter",                             -- Treesitter completions
        after = "nvim-cmp"
    }
    use {
	    "petertriho/cmp-git",                               -- github/gitlab completions
    }

    use {
	    "David-Kunz/cmp-npm",                               -- NPM dependencies manager
    }
    use {
	    "hrsh7th/cmp-nvim-lsp",                             -- LSP specific completions
        after = "nvim-cmp",
        config = function()
            require(G_PlugLL_Dir .. "cmp-nvim-lsp")
        end
    }
    use {
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        after = "nvim-cmp"
    }
    use {
        "hrsh7th/cmp-nvim-lsp-signature-help",
        after = "nvim-cmp"
    }

    -- Snippets
    use "rafamadriz/friendly-snippets"                      -- multiple community snippets
    use {
        "L3MON4D3/LuaSnip",                                 -- snippet engine
        event = "InsertEnter",
        after = "friendly-snippets",
    }

    -- LSP
    use "neovim/nvim-lspconfig"                             -- the LSP engine itself
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "jose-elias-alvarez/null-ls.nvim"
    use {
        "RRethy/vim-illuminate",                            -- highlights other uses of the word under the cursor
        event = "InsertEnter",
        config = function()
            require(G_PlugLL_Dir .. "illuminate")
        end
    }
    -- DAP
    use "mfussenegger/nvim-dap"
    use "rcarriga/nvim-dap-ui"

    -- Telescope & extensions.
    use {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        config = function()
            require(G_PlugLL_Dir .. "telescope")
        end
    }
    use {
        "nvim-telescope/Telescope-media-files.nvim",
    }
    use {                                                   -- C port of fzf for faster sorting
        'nvim-telescope/telescope-fzf-native.nvim',
        run = "make"
    }
    use {                                                   -- find files by frequency algorithm
        "nvim-telescope/telescope-frecency.nvim",
        requires = {"kkharji/sqlite.lua"}
    }
    use "LukasPietzschmann/telescope-tabs"                  -- switch between tabs
    use 'cljoly/telescope-repo.nvim'                        -- switch between git repos
    use 'benfowler/telescope-luasnip.nvim'                  -- luasnip integration
    use 'octarect/telescope-menu.nvim'                      -- custom menus

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use {
        "p00f/nvim-ts-rainbow",
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Git
    use {
        "lewis6991/gitsigns.nvim",
        event = "VimEnter",
        config = function()
            require(G_PlugLL_Dir .. "gitsigns")
        end
    }
    -- Github Copilot.
    use {
        "zbirenbaum/copilot.lua",
        event = "InsertEnter",
        config = function ()
            require(G_PlugLL_Dir .. "copilot")
        end
    }
    use { "zbirenbaum/copilot-cmp",
        after = {"copilot.lua", "nvim-cmp"},
        config = function ()
            require(G_PlugLL_Dir .. "cmp-copilot")
        end
    }

    -- Nvim-tree
    use "nvim-tree/nvim-web-devicons"                       -- icons as a dependency of many other plugins
    use {
        "kyazdani42/nvim-tree.lua",
        event = "VimEnter",
        config = function()
            require(G_PlugLL_Dir .. "nvim-tree")
        end
    }

    -- Languages, Programming Languages, etc.. Specifics.
    use {
        "lervag/vimtex",                                    -- Latex
        event = { "BufRead *.latex", "BufRead *.tex" },
    }
    use {
        "simrat39/rust-tools.nvim",                         -- Rust
        event = { "BufRead *.rs", "BufRead *.toml" }
    }
    use {                                                   -- Cargo.toml crates dependencies manager
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        config = function()
            require('crates').setup()
        end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
