local M = {}

function M.handler()

    local typescript = require( "typescript" )
    local ih = require( "inlay-hints" )
    local wk = require( "which-key" )

    typescript.setup({
        server = {
            on_attach = function( client, bufnr )
                ih.on_attach( client, bufnr )
                wk.register( {
                    name = "+lsp",
                    t = {
                        name = "+typescript",
                        i = { ":TypescriptAddMissingImports<CR>", "Add missing imports" }
                    }
                }, { mode = "n", prefix = "<leader>l", buffer = bufnr } )
            end,
            settings = {
                javascript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                    },
                },
                typescript = {
                    inlayHints = {
                        includeInlayEnumMemberValueHints = true,
                        includeInlayFunctionLikeReturnTypeHints = true,
                        includeInlayFunctionParameterTypeHints = true,
                        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
                        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                        includeInlayPropertyDeclarationTypeHints = true,
                        includeInlayVariableTypeHints = true,
                    },
                },
            },
        }
    })
end

return M
