return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		keys = function()
			local wk = require("which-key")

			wk.register({
				["<F5>"] = { ":lua require('dapui').toggle( { reset = true } )<CR>", "Toggle DAP UI" },
				["<F6>"] = { ":lua require('dap').toggle_breakpoint()<CR>", "Toggle breakpoint" },
				["<F9>"] = { ":lua require('dap').continue()<CR>", "DAP resume program" },
				["<F8>"] = { ":lua require('dap').step_over()<CR>", "DAP step over" },
				["<F7>"] = { ":lua require('dap').step_into()<CR>", "DAP step into" },
				["<S-F8>"] = { ":lua require('dap').step_out()<CR>", "DAP step out" },
			}, { mode = "n" })

			wk.register({
				d = {
					name = "+debug",
					s = {
						name = "+step",
						c = { "<cmd>lua require('dap').continue()<CR>", "Continue" },
						v = { "<cmd>lua require('dap').step_over()<CR>", "Step Over" },
						i = { "<cmd>lua require('dap').step_into()<CR>", "Step Into" },
						o = { "<cmd>lua require('dap').step_out()<CR>", "Step Out" },
					},
					h = {
						name = "+hover",
						h = { "<cmd>lua require('dap.ui.variables').hover()<CR>", "Hover" },
						v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
					},
					u = {
						name = "+ui",
						h = { "<cmd>lua require('dap.ui.widgets').hover()<CR>", "Hover" },
						f = {
							"<cmd>lua local widgets=require('dap.ui.widgets');widgets.centered_float(widgets.scopes)<CR>",
							"Float",
						},
					},
					r = {
						name = "+repl",
						o = { "<cmd>lua require('dap').repl.open()<CR>", "Open" },
						l = { "<cmd>lua require('dap').repl.run_last()<CR>", "Run Last" },
					},
					b = {
						name = "+breakpoints",
						c = {
							"<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
							"Breakpoint Condition",
						},
						m = {
							"<cmd>lua require('dap').set_breakpoint({ nil, nil, vim.fn.input('Log point message: ') })<CR>",
							"Log Point Message",
						},
						t = { "<cmd>lua require('dap').toggle_breakpoint()<CR>", "Create" },
					},
				},
			}, { mode = "n", prefix = "<leader>" })

			wk.register({
				d = {
					h = {
						v = { "<cmd>lua require('dap.ui.variables').visual_hover()<CR>", "Visual Hover" },
					},
				},
			}, { mode = "v", prefix = "<leader>" })
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup({
				floating = {
					border = "single",
					mappings = {
						close = { "q", "<Esc>" },
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
			require("nvim-dap-virtual-text").setup()

			require("user.languages.c").dap_setup()
			require("user.languages.cpp").dap_setup()
			require("user.languages.bash").dap_setup()
			require("user.languages.rust").dap_setup()
			require("user.languages.python").dap_setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
	},
}
