local wk = require("which-key")
local keymap = vim.keymap.set
local Util = require("user.utils")

--   [ VIM MODES ]   --
-----------------------
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
-----------------------

-- Disable q: and Q from triggering cmd commands history.
keymap("n", "q:", "<nop>", { noremap = true, silent = true })
keymap("n", "Q", "<nop>", { noremap = true, silent = true })

-- Keep cursor centered when scrolling with <C-u> and <C-d>.
keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- Keep current search highlighted centered.
keymap("n", "n", "nzzzv", { noremap = true, silent = true })
keymap("n", "N", "Nzzzv", { noremap = true, silent = true })

------------
-- Normal --
------------

-- Used to toggle between conceal levels.
local conceal_level = vim.o.conceallevel > 0 and vim.o.conceallevel or 3

-- stylua: ignore
wk.register({
	-- Navigate buffers and tabs.
	["<C-l>"] = { ":tabnext<CR>", "Next tab" },
	["<C-h>"] = { ":tabprevious<CR>", "Previous tab" },
	["<S-l>"] = { ":bnext<CR>", "Next buffer" },
	["<S-h>"] = { ":bprevious<CR>", "Previous buffer" },

	-- Resize windows with arrows.
	["<c-Up>"] = { ":resize +2<cr>", "Increase window horizontal size" },
	["<c-Down>"] = { ":resize -2<cr>", "Decrease window horizontal size" },
	["<c-Right>"] = { ":vertical resize +2<cr>", "Increase window vertical size" },
	["<c-Left>"] = { ":vertical resize -2<cr>", "Increase window vertical size" },

	-- Cancel search highlighting with ESC.
	["<ESC>"] = { ":nohlsearch<CR>", "" },

	-- Move text up and down.
	["<A-k>"] = { ":m .-2<CR>==", "Move selected text up" },
["<A-j>"] = { ":m .+1<CR>==", "Move selected text down" },

    ["<leader>p"] = {
		name = "+project",
		e = { ":Ex<CR>", "View file explorer mode in current dir" },
		r = { ":let @+ = getcwd()<CR>", "Root dir path to clipboard" },
    },
    ["<leader>U"] = {
        name = "+ui",
        c = { function() Util.toggle("conceallevel", false, {0, conceal_level}) end, "Toggle conceal level" },
        d = { Util.toggle_diagnostics, "Toggle diagnostics" },
        f = { require("user.lsp.format").toggle, "Toggle format on save" },
        l = { ":Lazy<CR>", "Lazy" },
        L = { ":LspInfo<CR>", "Lsp info" },
        h = { function() if vim.lsp.inlay_hint then vim.lsp.inlay_hint(0, nil) end end, "Toggle inlay hints" },
        m = { ":Mason<CR>", "Toggle Mason" },
        n = { function() Util.toggle_number() end, "Toggle line numbers" },
        s = { function() Util.toggle("spell") end, "Toggle spelling" },
        w = { function() Util.toggle("wrap") end, "Toggle word wrap" },
    }
}, { mode = "n" })

-- stylua: ignore
wk.register({
    ["<C-s>"] = { "<cmd>w<CR><esc>", "Save file" },
    ["<C-m>"] = { "<cmd>norm! K<CR>", "Manual of cursor keyword" }
}, { mode = { "n", "i", "v", "x" } })

------------
-- Visual --
------------

-- stylua: ignore
wk.register({
	-- Move text up and down.
	["<A-k>"] = { ":m .-2<CR>==", "Move selected text up" },
	["<A-j>"] = { ":m .+1<CR>==", "Move selected text down" },
}, { mode = "v" })

------------------
-- Visual Block --
------------------

-- stylua: ignore
wk.register({
	-- Move text up and down.
	["<A-k>"] = { ":m '<-2<CR>gv=gv", "Move selected text up" },
	["<A-j>"] = { ":m '>+1<CR>gv=gv", "Move selected text down" },
}, { mode = "x" })

-------------------
-- Terminal Mode --
-------------------

-- stylua: ignore
wk.register({
	-- Exit terminal mode easily.
	["<ESC>"] = { "<C-\\><C-N>", "Exit terminal mode" },
}, { mode = "t" })
