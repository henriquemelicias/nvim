return {
  "echasnovski/mini.bufremove",
  event = "VeryLazy",
  keys = {
    { "<M-t>n","<cmd>tabnew<CR>", desc = "New tab" },
    { "<M-t>d", function() require("mini.bufremove").delete(0, false) end, desc = "Close tab" },
    { "<M-t>D", function() require("mini.bufremove").delete(0, true) end, desc = "Close tab (Force)" },
    { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
    { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
  },
}
