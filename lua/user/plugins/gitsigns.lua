return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
            change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
            delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
            changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            interval = 1000,
            follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
            relative_time = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
            -- Options passed to nvim_open_win
            border = "single",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = {
            enable = false,
        },
        on_attach = function(buffer)
            local gs = require( "gitsigns" )
            local wk = require( "which-key" )

            wk.register( {
                ["]h"] = { gs.next_hunk, "Next Hunk" },
                ["[h"] = { gs.prev_hunk, "Previous Hunk" }
            }, { mode = "n", buffer = buffer } )

            wk.register( {
                name = "+git",
                h = {
                    name = "+hunk",
                    s = { ":Gitsigns stage_hunk<CR>", "Stage hunk" },
                    r = { ":Gitsigns reset_hunk<CR>", "Reset hunk" }
                }
            }, { mode = {"n", "v"}, prefix = "<leader>g", buffer = buffer } )

            wk.register( {
                name = "+git",
                h = {
                    name = "+hunk",
                    S = { gs.stage_buffer, "Stage Buffer" },
                    u = { gs.undo_stage_hunk, "Undo stage hunk" },
                    R = { gs.reset_buffer, "Reset buffer" },
                    p = { gs.preview_hunk, "Preview hunk" },
                    b = { function() gs.blame_line( {full = true} ) end, "Blame line" },
                    d = { gs.diffthis, "Diff this" },
                    D = { function() gs.diffthis( "~" ) end, "Diff this ~" },
                }
            }, { mode = "n", prefix = "<leader>g", buffer = buffer } )

            wk.register( {
                name = "+git",
                h = { ":<C-U>Gitsigns select_hunk<CR>", "Select hunk" }
            }, { mode = { "o", "x" }, prefix = "<leader>g", buffer = buffer })

        end,
    }
}
