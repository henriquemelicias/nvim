 -- Util functions.
local buffersUtil = require('user.utils.buffers')

 -- Tagbar toggle messes up width of Dapui, this is a fix.
function KeymapToggleTagbar()
    local isDapuiOpen = buffersUtil.isWindowFromBufferOpen( "DAP Scopes" )

    if isDapuiOpen then
        local dapui = require('dapui')
        dapui.close()
        dapui.open( { reset = true } )
    end
    vim.cmd([[
        :TagbarToggle
    ]])
end

-- Tagbar toggle messes up width of Dapui, this is a fix.
function KeymapToggleDapui()
    local isTagbarOpen = buffersUtil.isWindowFromBufferOpen( "Tagbar" )

    if isTagbarOpen then
        vim.cmd([[
            :TagbarClose
        ]])
    end

    require('dapui').toggle( { reset = true } )

    if isTagbarOpen then
        vim.cmd([[
            :TagbarOpen
        ]])
    end
end
