local create_autocmd = vim.api.nvim_create_autocmd

-- Util modules.
local SETTINGS = require( "user.configs.settings" )

-- Remove trailling whitespace on save.
create_autocmd( { "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
} )

-- Close buffers with 'q' silently.
create_autocmd( { "FileType" }, {
	pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
	callback = function()
		vim.cmd( [[
            nnoremap <silent> <buffer> q :close<CR>
            set nobuflisted
        ]] )
	end,
})

-- Delete bookmarks
-- create_autocmd({ "BufRead" }, { command = ":delm a-zA-Z0-9", })

-- Activate wrap and spell check on specific files.
create_autocmd( { "FileType" }, {
	pattern = SETTINGS.SPELL_FILE_PATTERNS,
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Autoresize buffers on window size change.
create_autocmd( { "VimResized" }, {
	callback = function()
		vim.cmd( "tabdo wincmd =" )
	end,
})

-- Format: Don't insert current leader and don't format comments.
create_autocmd( { "BufWinEnter" }, {
	callback = function()
		vim.cmd( "set formatoptions-=cro" )
	end,
})
