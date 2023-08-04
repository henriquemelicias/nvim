return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = true,
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
    { "<leader>pt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
    { "<leader>pT", "<cmd>TodoTelescope<cr>", desc = "Todo" },
  },
}
