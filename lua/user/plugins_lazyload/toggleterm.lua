local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    vim.notify("ERROR: Plugin toggleterm failed to load")
	return
end

toggleterm.setup{}
