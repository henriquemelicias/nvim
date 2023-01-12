local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify("ERROR: Plugin cmp failed to load")
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    vim.notify("ERROR: Plugin luasnip failed to load")
    return
end

local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

--   פּ ﯟ   some other good icons
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
    Copilot = "",
}

-- find more here: https://www.nerdfonts.com/cheat-sheet

-------------------
--- CMP plugins ---
-------------------

-- [Git]
-- Trigger / Feature
-------------------
-- : / Commits
-- # / Issues
-- @ / Mentions
-- # / Pull Requests (Github)
-- ! / Merge Requests (GitLab)
require("cmp_git").setup( {
    github = {
        issues = {
            state = "all"
        }
    },
} )

-- [NPM]
require("cmp-npm").setup( {} )


------------------
--- CMP setup  ---
------------------

cmp.setup {
    -- Luasnip capabilities.
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = cmp.mapping.preset.insert( {
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<m-o"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
        ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ["<C-a>"] = cmp.mapping {
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        -- ["<CR>"] = cmp.mapping.confirm { select = true },
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end,{
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    }),
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = function(entry, vim_item)

            -- Kind icons
            vim_item.kind = kind_icons[vim_item.kind] .. " " .. vim_item.kind

            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
                crates = "[Crates]",
                npm = "[NPM]",
                nvim_lsp = "[LSP]",
                nvim_lsp_document_symbol = "[LSP]",
                nvim_lsp_signature_help = "[LSP]",
                nvim_lua = "[Lua]",
                luasnip = "[Luasnip]",
                git = "[Git]",
                buffer = "[Buffer]",
                treesitter = "[Tree]",
                path = "[Path]",
                calc = '[Calc]',
                copilot = "[Copilot]",
                spell = '[Spell]',
                emoji = "[Emoji]",
                zsh = "[ZSH]",
            })[entry.source.name]

            return vim_item
        end,
    },

    -- Configure:
    -- keyword_length
    -- priority
    -- max_item_count
    sources = {
        { name = "crates", group_index = 1 },
        { name = "npm", group_index = 1, keyword_length = 4 },
        { name = "nvim_lsp", group_index = 2 },
        { name = "nvim_lsp_signature_help", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "treesitter", group_index = 2 },
        { name = "copilot", group_index = 2 },
        { name = "buffer", group_index = 2, keyword_length = 4 },
        { name = "path", group_index = 2 },
        { name = "calc", group_index = 2 },
        { name = "emoji", group_index = 2 },
        {
            name = "spell",
            option = {
                keep_all_entries = false,
                enable_in_context = function ()
                    return true
                end
            },
            group_index = 2,
            keyword_length = 5,
            max_item_count = 3,
        },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
}

-- Configuration in cmd line when using '/' key.
require'cmp'.setup.cmdline('/', {
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp_document_symbol' }
        },
        {
            { name = 'buffer', keyword_length = 4 }
        }
    )
})

-- Configuration in cmd line when using '?' key.
require'cmp'.setup.cmdline('?', {
    sources = cmp.config.sources(
        {
            { name = 'buffer', keyword_length = 4 }
        }
    )
})

-- Configuration in cmd line whe nusing ':' key.
require'cmp'.setup.cmdline(':', {
    sources = cmp.config.sources(
        {
            { name = 'cmdline' }
        },
        {
            { name = 'path' }
        }
    )
} )

-- -- Configuration for gitcommit file.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources(
        {
            { name = 'git' },
        },
        {
            { name = 'path' }
        },
        {
            { name = 'buffer', Keyword_length = 4 },
        }
    )
} )

