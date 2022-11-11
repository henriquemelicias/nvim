local masonUtils = require("user.utils.mason")

local dap = require('dap')

-- Check if rust debugger is installed.
if not masonUtils.isPackageInstalled("codelldb") then

    vim.notify("ERROR: [Rust] codelldb is not installed. Install it with Mason or add it to the default debuggers list in nvim/init.lua" )
    return
end

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
  },
}
