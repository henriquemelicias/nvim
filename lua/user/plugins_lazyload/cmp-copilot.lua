 -- CMP Copilot Integration.
local copilot_cmp_status_ok, copilot_cmp = pcall(require, "copilot_cmp")
if not copilot_cmp_status_ok then
    vim.notify("ERROR: Plugin copilot-cmp failed to load")
    return
end

copilot_cmp.setup()
