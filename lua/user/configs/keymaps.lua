local wk = require("which-key")
local keymap = vim.keymap.set

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

-- stylua: ignore
wk.register({
	-- Navigate buffers (tabs)
	["<C-l>"] = { ":bnext<CR>", "Next tab" },
	["<C-h>"] = { ":bprevious<CR>", "Previous tab" },

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
}, { mode = "n" })

-- stylua: ignore
wk.register({
	p = {
		name = "+project",
		e = { ":Ex<CR>", "View file explorer mode in current dir" },
		r = { ":let @+ = getcwd()<CR>", "Root dir path to clipboard" },
	},
}, { mode = "n", prefix = "<leader>" })

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
