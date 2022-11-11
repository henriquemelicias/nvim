local status_ok, todo_comments = pcall(require, "todo-comments")
if not status_ok then
    vim.notify("ERROR: Plugin todo-comments failed to load")
	return
end

todo_comments.setup {}
