return {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
        "rouge8/neotest-rust",
    },
    opts = {
        adapters = {
            ["neotest-rust"] = {}
        },
    }
}
