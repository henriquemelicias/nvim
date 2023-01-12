-- Shorten function name.
local keymap = vim.api.nvim_set_keymap

-- Keymap options.
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

-- Remap space as leader key.
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


--   [ VIM MODES ]
---------------------------
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
---------------------------

------------
-- Normal --
------------

-- Better window navigation.
keymap("n", "<c-h>", "<C-w>h", opts)
keymap("n", "<c-j>", "<C-w>j", opts)
keymap("n", "<c-k>", "<C-w>k", opts)
keymap("n", "<c-l>", "<C-w>l", opts)

-- Resize with arrows.
keymap("n", "<c-Up>", ":resize -2<CR>", opts)
keymap("n", "<c-Down>", ":resize +2<CR>", opts)
keymap("n", "<c-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<c-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers (tabs).
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Create/close new buffers.
keymap("n", "<C-t>n", ":tabnew<CR>", opts )
keymap("n", "<C-t>d", ":bdelete<CR>", opts )

-- Cancel search highlighting with ESC.
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)


------------
-- Insert --
------------


------------
-- Visual --
------------

-- Indent selected.
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down.
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)


------------------
-- Visual Block --
------------------

-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)


--------------
-- Terminal --
--------------

-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


---------------
-- Plugins --
---------------

-- NvimTree
keymap("n", "<leader>q", ":NvimTreeToggle<cr>", opts)

-- Tagbar (Classes, Functions, Variables... menu)
keymap("n", "<leader>e", "<cmd>lua require('user.utils.keymaps').toggleTagbar()<CR>", opts)

-- DAPUI
keymap("n", "<leader>d", "<cmd>lua require('user.utils.keymaps').toggleDapui()<CR>", opts )

-- Telescope Builtin
keymap("n", "<leader>fm", ":Telescope builtin<CR>", opts)                   -- menu with builtin functions
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)                -- find files
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)                 -- find with grep
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)                   -- buffers
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)                 -- help tags

-- Telescope extensions
keymap("n", "<leader>tm", ":Telescope menu<CR>", opts)                      -- custom menu
keymap("n", "<leader>tf", ":Telescope frecency<CR>", opts)                  -- find files by frequency algorithm
keymap("n", "<leader>tt", ":Telescope telescope-tabs list_tabs<CR>", opts ) -- switch between tabs
keymap("n", "<leader>tx", ":Telescope media_files<CR>", opts )              -- find media files
keymap("n", "<leader>tp", ":Telescope projects<CR>", opts)                  -- see projects
keymap("n", "<leader>td", ":TodoTelescope<CR>", opts)                       -- see todos and other tagged temporary comments
keymap("n", "<leader>tr", ":Telescope repo<CR>", opts)                      -- switch between vcs (git) repos
keymap("n", "<leader>tc", ":Telescope neoclip<CR>", opts)                   -- clip manager
keymap("n", "<leader>ts", ":Telescope luasnip<CR>", opts)                   -- snippets

-- Copilot
keymap("n", "<leader>cc", ":Copilot panel<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', opts)

-- DAP
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
