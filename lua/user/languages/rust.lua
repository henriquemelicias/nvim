local M = {}

function M.dap_setup()
	local dap = require("dap")

	dap.configurations.rust = {
		{
			name = "Launch",
			type = "lldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
			args = {},
			initCommands = function()
				-- Find out where to look for the pretty printer Python module
				local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))

				local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
				local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

				local commands = {}
				local file = io.open(commands_file, "r")
				if file then
					for line in file:lines() do
						table.insert(commands, line)
					end
					file:close()
				end
				table.insert(commands, 1, script_import)

				return commands
			end,
		},
	}
end

function M.handler()
	local rust_tools = require("rust-tools")
	local wk = require("which-key")

	local ok, mason_registry = pcall(require, "mason-registry")
	local adapter ---@type any
	if ok then
		-- rust tools configuration for debugging support
		local codelldb = mason_registry.get_package("codelldb")
		local extension_path = codelldb:get_install_path() .. "/extension/"
		local codelldb_path = extension_path .. "adapter/codelldb"
		local liblldb_path = vim.fn.has("mac") == 1 and extension_path .. "lldb/lib/liblldb.dylib"
			or extension_path .. "lldb/lib/liblldb.so"
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path)
	end

	rust_tools.setup({
		dap = {
			adapter = adapter,
		},
		tools = {
			on_initialized = function()
				vim.cmd([[
                    augroup RustLSP
                      autocmd CursorHold                      *.rs silent! lua vim.lsp.buf.document_highlight()
                      autocmd CursorMoved,InsertEnter         *.rs silent! lua vim.lsp.buf.clear_references()
                      autocmd BufEnter,CursorHold,InsertLeave *.rs silent! lua vim.lsp.codelens.refresh()
                    augroup END
                ]])
			end,
			inlay_hints = {
				only_current_line = true,
			},
			hover_actions = {
				auto_focus = true,
			},
		},
		server = {
			on_attach = function(_, bufnr)
				wk.register({
					name = "+lsp",
					l = {
						name = "+rust",
						a = { rust_tools.hover_actions.hover_actions, "Hover actions" },
						d = { rust_tools.debuggables.debuggables, "Debuggables" },
						D = { ":RustLastDebug<CR>", "Last debuggable" },
						h = { rust_tools.inlay_hints.enable, "Enable inlay hints" },
						H = { rust_tools.inlay_hints.disable, "Disable inlay hints" },
						r = { rust_tools.runnables.runnables, "Runnables" },
						j = { rust_tools.join_lines.join_lines, "Join lines" },
						R = { ":RustLastRun<CR>", "Last runnable" },
						m = { rust_tools.expand_macro.expand_macro, "Expand macro" },
						c = { rust_tools.open_cargo_toml.open_cargo_toml, "Open cargo.toml" },
						p = { rust_tools.parent_module.parent_module, "Go to parent module" },
						s = { ":RustSSR<CR>", "Structural search and replace" },
					},
				}, { mode = "n", prefix = "<leader>l", buffer = bufnr })
			end,
		},
	})

	return {
		servers = {
			["rust-analyzer"] = {
				cargo = {
					features = { "all" },
				},
				-- Add clippy lints for Rust.
				check = {
					features = { "all" },
					command = "clippy",
					extraArgs = { "--no-deps" },
				},
				checkOnSave = true,
				procMacro = {
					enable = true,
					ignored = {
						["async-trait"] = { "async_trait" },
						["napi-derive"] = { "napi" },
						["async-recursion"] = { "async_recursion" },
					},
				},
			},
		},
	}
end

return M
