local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
    vim.notify("ERROR: Plugin luasnip failed to load")
    return
end

luasnip.config.set_config {
    -- Tells LuaSnip to remember to keep around the last snippet.
    history = true,
    updateevents = "TextChanged, TextChangedI",
    enable_autosnippets = true,
    ext_opts = {
        [require("luasnip.util.types").choiceNode] = {
            active = {
                virt_text = { { "*", "Gruvbox" } }
            }
        }
    }
}

-- expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-e>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

-- selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end)

vim.keymap.set({ "i", "s" }, "<C-h>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(-1)
    end
end)

-- Snippets.
require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/snippets"})
