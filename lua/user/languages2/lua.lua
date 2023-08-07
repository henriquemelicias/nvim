local M = {}

function M.handler( lsp )
	require("lspconfig").lua_ls.setup( lsp.nvim_lua_ls() )
end

return M
