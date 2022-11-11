local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
    vim.notify("ERROR: Plugin indent_blankline failed to load")
	return
end

-- Wrap line.
-- Indent lines.
vim.opt.list = true

indent_blankline.setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
}

