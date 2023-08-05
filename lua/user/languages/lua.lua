local M = {}

function M.lua_ls_handler(lsp)
	require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
end

return M
