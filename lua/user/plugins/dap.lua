return {
	"mfussenegger/nvim-dap",
    event = "VeryLazy",
	dependencies = {
		{
			"jay-babu/mason-nvim-dap.nvim",
			dependencies = "mason.nvim",
			cmd = { "DapInstall", "DapUninstall" },
			opts = {
				-- Makes a best effort to setup the various debuggers with
				-- reasonable debug configurations
				automatic_installation = true,

				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},

				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
				},
			},
		},
		{
			"rcarriga/nvim-dap-ui",
			event = "VeryLazy",
			dependencies = { "mfussenegger/nvim-dap" },
			config = function()
				require("dapui").setup({
					controls = {
						element = "repl",
						enabled = true,
						icons = {
							disconnect = "",
							pause = "",
							play = "",
							run_last = "",
							step_back = "",
							step_into = "",
							step_out = "",
							step_over = "",
							terminate = "",
						},
					},
					element_mappings = {},
					expand_lines = true,
					floating = {
						border = "single",
						mappings = {
							close = { "q", "<Esc>", "<C-[>" },
						},
					},
					force_buffers = true,
					icons = {
						collapsed = "",
						current_frame = "",
						expanded = "",
					},
					layouts = {
						{
							elements = {
								{
									id = "scopes",
									size = 0.25,
								},
								{
									id = "breakpoints",
									size = 0.25,
								},
								{
									id = "stacks",
									size = 0.25,
								},
								{
									id = "watches",
									size = 0.25,
								},
							},
							position = "left",
							size = 60,
						},
						{
							elements = {
								{
									id = "repl",
									size = 0.5,
								},
								{
									id = "console",
									size = 0.5,
								},
							},
							position = "bottom",
							size = 10,
						},
					},
					mappings = {
						edit = "e",
						expand = { "<CR>", "<2-LeftMouse>" },
						open = "o",
						remove = "d",
						repl = "r",
						toggle = "t",
					},
					render = {
						indent = 1,
						max_value_lines = 100,
					},
				})

				local dap, dapui = require("dap"), require("dapui")
				dap.listeners.after.event_initialized["dapui_config"] = function()
					dapui.open({ reset = true })
				end
				dap.listeners.before.event_terminated["dapui_config"] = function()
					dapui.close()
				end
				dap.listeners.before.event_exited["dapui_config"] = function()
					dapui.close()
				end

				-- Languages Debuggers go here --
				require("dapui")
			end,
		},
		{
			"theHamsta/nvim-dap-virtual-text",
		},
	},
	keys = function()
		local wk = require("which-key")

            -- stylua: ignore
			wk.register({
				["<F4>"] = { ":lua require('dapui').toggle( { reset = true } )<CR>", "Toggle DAP UI" },
				["<F5>"] = { ":lua require('dapui').eval()<CR>", "DAP eval" },
				["<F6>"] = { ":lua require('dap').toggle_breakpoint()<CR>", "Toggle breakpoint" },
				["<F7>"] = { ":lua require('dap').step_into()<CR>", "DAP step into" },
				["<F8>"] = { ":lua require('dap').step_over()<CR>", "DAP step over" },
				["<S-F8>"] = { ":lua require('dap').step_out()<CR>", "DAP step out" },
				["<F9>"] = { ":lua require('dap').continue()<CR>", "DAP resume program" },
			}, { mode = "n" })

            -- stylua: ignore
			wk.register({
				["<F5>"] = { ":lua require('dapui').eval()<CR>", "DAP eval" },
			}, { mode = { "n", "v" } })

            -- stylua: ignore
			wk.register({
				d = {
					name = "+debug",
					s = {
						name = "+step/run",
						c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
						v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
						i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
						o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
						r = { "<cmd>lua require('dap').run_to_cursor()<CR>", "Run to cursor" },
						l = { "<cmd>lua require('dap').run_last()<CR>", "Run last" },
					},
					v = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Variables hover" },
					V = { "<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>", "Variables float", },
					r = {
						name = "+repl",
						o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
						l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
					},
					b = {
						name = "+breakpoints",
						c = { "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "Breakpoint Condition", },
						m = { "<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>", "Log Point Message", },
						t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
					},
				},
			}, { mode = "n", prefix = "<leader>" })
	end,
	config = function()
		local SETTINGS = require("user.configs.settings")
		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

		for name, sign in pairs(SETTINGS.ICONS.DAP) do
			sign = type(sign) == "table" and sign or { sign }
			vim.fn.sign_define(
				"Dap" .. name,
				{ text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
			)
		end
	end,
}
