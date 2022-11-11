local rust_tools_status_ok, _ = pcall(require, "rust-tools")
if not rust_tools_status_ok then
    return
end

require "user.languages.rust.dap"
require "user.languages.rust.rust-tools"
