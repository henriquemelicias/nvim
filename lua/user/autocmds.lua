-- Util modules.
local keymapUtils = require("user.utils.keymaps")

-- Files to use with an IDE like environemtn.
local ide_environment_filetypes = vim.api.nvim_get_var("IDE_FILE_PATTERNS")

-- -- Entering Vim: IDE environment startup.
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     pattern = ide_environment_filetypes,
-- 	callback = function()
--         vim.cmd(
--             [[
--                 :NvimTreeOpen
--                 :Tagbar
--                 :wincmd w
--             ]])
-- 	end,
-- })

-- Close NvmTree when using :q, :wq or :qall.
-- Sometimes nvim-tree bugged and didn't close correctly when closing, blocking the program exit.
vim.api.nvim_create_autocmd( { "QuitPre" }, {
    callback = function()
        vim.cmd(
            [[
                :NvimTreeClose
            ]]
        )
    end,
} )

-- Close buffers with 'q' silently.
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd([[
            nnoremap <silent> <buffer> q :close<CR> 
            set nobuflisted 
        ]])
	end,
})

-- Auto open tagbar on new tabs/buffers.
-- Tagbar toggle messes up Dapui, this has a fix for it.
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    pattern = ide_environment_filetypes,
	callback = function()
        -- keymapUtils.toggleTagbar()
	end,
})

-- Activate wrap and spell check on specific files.
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "gitcommit", "markdown", "txt"},
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Autoresize buffers on window size change.
vim.api.nvim_create_autocmd({ "VimResized" }, {
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

-- Java.
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

