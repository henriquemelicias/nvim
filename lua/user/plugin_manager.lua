-- Uses lazy.nvim for the plugin manager.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

-- Options.
local opts = {
	install = {
		colorscheme = { "gruvbox-material" },
	},
	checker = { -- check updates
		enabled = true,
		notify = true,
		frequency = 3600, -- every hour
	},
}

-- Setup lazy.nvim, using the directory plugins where each file is a plugin.
require("lazy").setup({
	spec = {
        -- Plugins.
		{ import = "user.plugins" },

        -- Languages.
        { import = "user.languages" }
	},
}, opts)
