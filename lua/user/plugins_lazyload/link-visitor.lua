local status_ok, illuminate = pcall(require, "link-visitor")
if not status_ok then
    vim.notify("ERROR: Plugin link-visitor failed to load")
	return
end

require("link-visitor").setup()
