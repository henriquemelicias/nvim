return {
	"nvim-neotest/neotest",
	opts = {
		-- Can be a list of adapters like what neotest expects,
		-- or a list of adapter names,
		-- or a table of adapter names, mapped to adapter configs.
		-- The adapter will then be automatically loaded with the config.
		adapters = {},
		-- Example for loading neotest-go with a custom config
		-- adapters = {
		--   ["neotest-go"] = {
		--     args = { "-tags=integration" },
		--   },
		-- },
		status = { virtual_text = true },
		output = { open_on_run = true },
		quickfix = {
			open = function()
				if require("user.utils").has("trouble.nvim") then
					vim.cmd("Trouble quickfix")
				else
					vim.cmd("copen")
				end
			end,
		},
	},
	config = function(_, opts)
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					-- Replace newline and tab characters with space for more compact diagnostics
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		if opts.adapters then
			local adapters = {}
			for name, config in pairs(opts.adapters or {}) do
				if type(name) == "number" then
					if type(config) == "string" then
						config = require(config)
					end
					adapters[#adapters + 1] = config
				elseif config ~= false then
					local adapter = require(name)
					if type(config) == "table" and not vim.tbl_isempty(config) then
						local meta = getmetatable(adapter)
						if adapter.setup then
							adapter.setup(config)
						elseif meta and meta.__call then
							adapter(config)
						else
							error("Adapter " .. name .. " does not support setup")
						end
					end
					adapters[#adapters + 1] = adapter
				end
			end
			opts.adapters = adapters
		end

		require("neotest").setup(opts)
	end,
    -- stylua: ignore
    keys = function()

        require("which-key").register({
            name = "+test (eXperiment)",
            s = {
                name = "+summary commands guide",
                a = { "<nop>", "attach" },
                M = { "<nop>", "clear marked" },
                T = { "<nop>", "clear target" },
                d = { "<nop>", "debug" },
                D = { "<nop>", "debug marked" },
                e = { "<nop>", "expand all" },
                i = { "<nop>", "jump to test" },
                m = { "<nop>", "mark" },
                J = { "<nop>", "next failed" },
                o = { "<nop>", "output" },
                K = { "<nop>", "prev failed" },
                r = { "<nop>", "run" },
                R = { "<nop>", "run marked" },
                O = { "<nop>", "short" },
                u = { "<nop>", "stop" },
                t = { "<nop>", "target" },
                w = { "<nop>", "watch" },
            }

        }, { mode = "n", prefix = "<leader>x" })
        return {
            { "<leader>xt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file" },
            { "<leader>xT", function() require("neotest").run.run(vim.loop.cwd()) end, desc = "Run all test files" },
            { "<leader>xr", function() require("neotest").run.run() end, desc = "Run nearest" },
            { "<leader>xx", function() require("neotest").summary.toggle() end, desc = "Toggle summary" },
            { "<leader>xo", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show output" },
            { "<leader>xO", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
            { "<leader>xS", function() require("neotest").run.stop() end, desc = "Stop" },
        }
    end
    ,
}
