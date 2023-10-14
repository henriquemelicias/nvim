local M = {}

---@type PluginLspKeys
M._keys = nil

---@return (LazyKeys|{has?:string})[]
function M.get()
	local format = function()
		require("user.lsp.format").format({ force = true })
	end
	if not M._keys then
        ---@class PluginLspKeys
        -- stylua: ignore
        M._keys =  {
            { "gd", vim.lsp.buf.definition, desc = "LSP jump to symbol definition" },
            { "gD", vim.lsp.buf.declaration, desc = "LSP jump to symbol declaration" },
            { "gI", vim.lsp.buf.implementation, desc = "LSP jump to symbol implementation" },
            { "gl", vim.diagnostic.open_float, desc = "LSP (L)ook at diagnostics in a float" },
            { "K", vim.lsp.buf.hover, desc = "LSP display highlighted symbol info" },
            { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "LSP signature help", has = "signatureHelp" },
            { "]d", M.diagnostic_goto(true), desc = "LSP next diagnostic" },
            { "[d", M.diagnostic_goto(false), desc = "LSP previous diagnostic" },
            { "]e", M.diagnostic_goto(true, "ERROR"), desc = "LSP next error" },
            { "[e", M.diagnostic_goto(false, "ERROR"), desc = "LSP previous error" },
            { "]w", M.diagnostic_goto(true, "WARN"), desc = "LSP next warning" },
            { "[w", M.diagnostic_goto(false, "WARN"), desc = "LSP previous warning" },
            { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
            { "<leader>lA", function() vim.lsp.buf.code_action({ context = { only = { "source", }, diagnostics = {}, }, }) end, desc = "Source Action", has = "codeAction", },
            { "<leader>ld", vim.lsp.buf.type_definition, desc = "List symbol definitions" },
            { "<leader>lf", format, desc = "Format document", has = "formatting" },
            { "<leader>lf", format, desc = "Format range", mode = "v", has = "rangeFormatting" },
            { "<leader>lk", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
            { "<leader>lr", vim.lsp.buf.references, desc = "List symbol references" },
        }
		M._keys[#M._keys + 1] = { "<leader>lR", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
	end
	return M._keys
end

---@param method string
function M.has(buffer, method)
	method = method:find("/") and method or "textDocument/" .. method
	local clients = vim.lsp.get_active_clients({ bufnr = buffer })
	for _, client in ipairs(clients) do
		if client.supports_method(method) then
			return true
		end
	end
	return false
end

function M.resolve(buffer)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = {} ---@type table<string,LazyKeys|{has?:string}>

	local function add(keymap)
		local keys = Keys.parse(keymap)
		if keys[2] == false then
			keymaps[keys.id] = nil
		else
			keymaps[keys.id] = keys
		end
	end
	for _, keymap in ipairs(M.get()) do
		add(keymap)
	end

	local opts = require("user.utils").opts("nvim-lspconfig")
	local clients = vim.lsp.get_active_clients({ bufnr = buffer })
	for _, client in ipairs(clients) do
		local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
		for _, keymap in ipairs(maps) do
			add(keymap)
		end
	end
	return keymaps
end

function M.on_attach(_, buffer)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = M.resolve(buffer)

	for _, keys in pairs(keymaps) do
		if not keys.has or M.has(buffer, keys.has) then
			local opts = Keys.opts(keys)
			---@diagnostic disable-next-line: no-unknown
			opts.has = nil
			opts.silent = opts.silent ~= false
			opts.buffer = buffer
			vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
		end
	end
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
