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

function M.rust_analyzer_handler()
	local rust_tools = require("rust-tools")
	local ih = require("inlay-hints")
	local wk = require("which-key")

	rust_tools.setup({
		tools = {
			on_initialized = function()
				ih.set_all()
			end,
			inlay_hints = {
				only_current_line = true,
			},
			hover_actions = {
				auto_focus = true,
			},
		},
		server = {
			on_attach = function(client, bufnr)
				ih.on_attach(client, bufnr)

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
end

return M
