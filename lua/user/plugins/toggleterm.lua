return {
    'akinsho/toggleterm.nvim',
    event = "VeryLazy",
    version = "*",
    config = true,
    opts = {
        on_open = function(term)
            vim.cmd("startinsert!")
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<C-[>", "<cmd>close<CR>", {noremap = true, silent = true})
            vim.api.nvim_buf_set_keymap(term.bufnr, "n", "<ESC>", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        start_in_insert = false,
        autochdir = true,
    },
    keys = function ()
        local wk = require( "which-key" )
        local _ = require('toggleterm.terminal').Terminal

        wk.register( {
            t = {
                name = "+terminal float",
                t = { ":1ToggleTerm direction=float<CR>", "Default terminal 1" },
                a = { ":0ToggleTerm direction=float<CR>", "Toggle all" },
                ["1"] = { ":1ToggleTerm direction=float<CR>", "Terminal 1" },
                ["2"] = { ":2ToggleTerm direction=float<CR>", "Terminal 2" },
                ["3"] = { ":3ToggleTerm direction=float<CR>", "Terminal 3" },
                ["4"] = { ":4ToggleTerm direction=float<CR>", "Terminal 4" },
                ["5"] = { ":5ToggleTerm direction=float<CR>", "Terminal 5" },
                ["6"] = { ":6ToggleTerm direction=float<CR>", "Terminal 6" },
                ["7"] = { ":7ToggleTerm direction=float<CR>", "Terminal 7" },
                ["8"] = { ":8ToggleTerm direction=float<CR>", "Terminal 8" },
                ["9"] = { ":9ToggleTerm direction=float<CR>", "Terminal 9" },
                s = { ":ToggleTermSendCurrentLine ", "Send current line to terminal <input>" },
            },
            T = {
                name = "+terminal bottom",
                t = { ":1ToggleTerm direction=horizontal<CR>", "Default terminal 1" },
                a = { ":0ToggleTerm direction=horizontal<CR>", "Toggle all" },
                ["1"] = { ":1ToggleTerm direction=horizontal<CR>", "Terminal 1" },
                ["2"] = { ":2ToggleTerm direction=horizontal<CR>", "Terminal 2" },
                ["3"] = { ":3ToggleTerm direction=horizontal<CR>", "Terminal 3" },
                ["4"] = { ":4ToggleTerm direction=horizontal<CR>", "Terminal 4" },
                ["5"] = { ":5ToggleTerm direction=horizontal<CR>", "Terminal 5" },
                ["6"] = { ":6ToggleTerm direction=horizontal<CR>", "Terminal 6" },
                ["7"] = { ":7ToggleTerm direction=horizontal<CR>", "Terminal 7" },
                ["8"] = { ":8ToggleTerm direction=horizontal<CR>", "Terminal 8" },
                ["9"] = { ":9ToggleTerm direction=horizontal<CR>", "Terminal 9" },
            },
        }, { mode = "n", prefix = "<leader>", noremap = true, silent = true })

        wk.register( {
            t = {
                name = "+terminal",
                v = { ":ToggleTermSendVisualSelection ", "Send selection to terminal <input>" },
            }
        }, { mode = "v", prefix = "<leader>", noremap = true, silent = true } )
    end
}
