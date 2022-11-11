local themePlugin = "gruvbox"

local status_ok, colorscheme = pcall(require, themePlugin)
if not status_ok then
    vim.notify("ERROR: Plugin " .. themePlugin .. " failed to load")
    return
end

-- Default options:
colorscheme.setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
})

local colorscheme_status_ok, _ = pcall(vim.cmd, "colorscheme " .. themePlugin )

if not colorscheme_status_ok then
  vim.notify("ERROR: failed to set colorscheme " .. themePlugin )
  return
end
