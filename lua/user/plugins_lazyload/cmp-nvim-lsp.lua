local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    vim.notify("ERROR: Plugin cmp_nvim_lsp failed to load")
	return
end

local lsp = require("user.lsp.handlers")
lsp.capabilities = cmp_nvim_lsp.default_capabilities(lsp.capabilities)
