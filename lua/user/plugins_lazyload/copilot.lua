local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
    vim.notify("ERROR: Plugin copilot failed to load")
    return
end

copilot.setup({
    panel = {
        auto_refresh = true,
    },
    suggestion = {
        auto_trigger = false,
    },
    -- Copilot specific nodejs version.
    -- Use nvm install <VERSION> to install specific version and change line below.
    copilot_node_command = vim.fn.expand("$HOME") .. "/.local/share/nvm/versions/node/v16.18.1/bin/node"
})

-- CMP Copilot Integration.
local copilot_cmp_status_ok, copilot_cmp = pcall(require, "copilot_cmp")
if not copilot_cmp_status_ok then
    vim.notify("ERROR: Plugin copilot-cmp failed to load")
    return
end

copilot_cmp.setup()
