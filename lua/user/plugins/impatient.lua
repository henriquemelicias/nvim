local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
    vim.notify("ERROR: Plugin impatient failed to load")
    return
end

impatient.enable_profile()
