local debuggers = vim.api.nvim_get_var("DAP_DEBUGGERS")
local servers = vim.api.nvim_get_var("LSP_SERVERS")

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
local mason_reg = require("mason-registry")

-- FORMATTERS

-- LINTERS

-- DAP DEBUGGERS
for _, debugger in pairs(debuggers) do
    if not mason_reg.is_installed( debugger ) then
        cmd("MasonInstall " .. debugger)
    end
end

-- LSP SERVERS
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig = require("lspconfig")
local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end
