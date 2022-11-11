local M = {}

local mason_reg = require("mason-registry")

-- Check if package with the specified name is installed.
--
-- @param packageName package name
-- @returns true if package is installed
function M.isPackageInstalled( packageName )

        return mason_reg.is_installed( packageName )
end

function M.installPackagesFromTable( packageTable )
    for _, package in pairs( packageTable ) do
        if M.isPackageInstalled( package ) then
            vim.notify("[Mason] Installing package" .. package)
            vim.cmd(":MasonInstall " .. package)
        end
    end
end

return M
