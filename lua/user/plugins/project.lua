local status_ok, project = pcall(require, "project_nvim")
if not status_ok then
    vim.notify("ERROR: Plugin project_nvim failed to load")
	return
end
project.setup({

	detection_methods = { "pattern" },

	-- patterns used to detect root dir, when **"pattern"** is in detection_methods
	patterns = { ".git", "Makefile", "package.json", "justfile" },
})

local tele_status_ok, telescope = pcall(require, "telescope")
if not tele_status_ok then
    vim.notify("ERROR: Plugin telescope failed to load")
	return
end

telescope.load_extension('projects')
