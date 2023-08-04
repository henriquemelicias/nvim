return {                                                   -- Cargo.toml crates dependencies manager
    'saecki/crates.nvim',
    event = { "BufRead Cargo.toml" },
    config = function()
        require('crates').setup()
    end,
}
