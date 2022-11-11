local M = {}

-- Check if buffer with specified name as a window open.
--
-- @param bufferName partial string that must be contained in the buffer's absolute path string
-- @returns true if buffer has window open
function M.isWindowFromBufferOpen( bufferName )
    local isWindowOpen = false

    -- Get windows.
    local currentTabpage = vim.api.nvim_get_current_tabpage()
    local windows = vim.api.nvim_tabpage_list_wins( currentTabpage )

    -- Check if buffer has window open.
    for _, windowId in pairs(windows) do
        local bufferPath = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf( windowId ) )

        if string.find( bufferPath, bufferName ) then
            isWindowOpen = true
            break
        end
    end

    return isWindowOpen;
end

return M
