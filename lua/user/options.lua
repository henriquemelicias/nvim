-- See :help options.
local options = {

    backup = false,                          -- creates a backup file
    cmdheight = 1,                           -- more space in the neovim command line for displaying messages
    conceallevel = 0,                        -- so that `` is visible in markdown files
    fileencoding = "utf-8",                  -- the encoding written to a file
    hlsearch = true,                         -- highlight all matches on previous search pattern
    ignorecase = true,                       -- ignore case in search patterns
    mouse = "a",                             -- allow the mouse to be used in neovim
    pumheight = 10,                          -- pop up menu height
    showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2,                         -- always show tabs
    smartcase = true,                        -- smart case
    smartindent = true,                      -- make indenting smarter again
    spell = true,                            -- spelling suggestions
    spelllang = { "en_us", "pt_pt", "de_de"},-- spelling suggestions language
    splitbelow = true,                       -- force all horizontal splits to go below current window
    splitright = true,                       -- force all vertical splits to go to the right of window
    swapfile = false,                        -- creates a swapfile
    termguicolors = true,                    -- set term gui colors (most terminals support this)
    timeoutlen = 500,                        -- time to wait for a mapped sequence to complete (in ms)
    undofile = true,                         -- enable persistent undo
    updatetime = 300,                        -- faster completion (4000ms default)
    writebackup = false,                     -- if file is being edited by another program = not able to edit
    expandtab = true,                        -- convert tabs to spaces
    shiftwidth = 4,                          -- the number of spaces inserted for each indentation
    tabstop = 4,                             -- insert 2 spaces for a tab
    cursorline = true,                       -- highlight the current line
    number = true,                           -- set numbered lines
    relativenumber = true,                   -- set relative numbered lines
    numberwidth = 4,                         -- set number column width to 2 {default 4}
    signcolumn = "yes",                      -- always show the sign column
    scrolloff = 8,                           -- minimal number of screen lines to keep above/below cursor.
    sidescrolloff = 8,                       -- minimal number of screen columns to keep right/left cursor.
    guifont = "monospace:h17",               -- the font used in graphical neovim applications
    breakindent = true,                      -- indent line wraps
    cursorcolumn = true,

    -- Wrap line.
    wrap = false,                            -- display lines as one long line
    colorcolumn = "121",                     -- color limit column

    -- Completion settings..
    -- :help completeopt
    completeopt = {'menuone', 'noselect', 'noinsert'},
    shortmess = vim.opt.shortmess + { c = true},
}


-- Enable options above.
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd "set clipboard+=unnamedplus"       -- allow use of system clipboard
vim.cmd "set whichwrap+=<,>,[,],h,l"       -- allow specified keys to move to previous/next line when the cursor is on the first/last character in the line
vim.cmd "set iskeyword+=-"
