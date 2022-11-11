local status_ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify( "ERROR: Plugin nvim-treesitter failed to load" )
  return
end

treesitter_configs.setup {
    ensure_installed = "all",
    sync_install = false,
    ignore_install = { "" },  -- List of parsers to ignore installing
    highlight = {
        enable = true,        -- false will disable the whole extension
        disable = { "" },     -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    autopairs = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = { "yaml" }
    },
    rainbow = {
        enable = true,
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
    },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
}
