local SETTINGS = require( "user.configs.settings" )

-- See :help options.
local OPTIONS = {
    -- General --
    autoread = true,        -- read a file again if it has been changed externally
    backup = true,          -- make a backup before overwriting a file and leave it around
    backupdir = {           -- backup directory
        SETTINGS.BACKUP_DIR
    },
    mouse = "a",            -- allow mouse to be used in Neovim
    sessionoptions = {      -- options when saving and restoring a session
        "buffers",
        "curdir",
        "tabpages",
        "winsize",
    },
    swapfile = false,       -- creates a swap file
    timeoutlen = 500,       -- time to wait for a mapped sequence to complete (in ms)
    undofile = true,        -- enable persistent undo

    -- Completion --
    completeopt = {         -- insert mode completion options
        "menuone",
        "noselect",
        "noinsert",
        "preview",          -- TODO check what difference this option makes
    },
    shortmess = vim.opt.shortmess + "c",
    updatetime = 50,        -- faster update time interval (CursorHold autocommand event)

    -- Language --
    spell = false,          -- spelling suggestions TODO easy turn on and off, or maybe per file type
    spelllang = {           -- languages to spell check. see "nvim/spell" directory
        "en_us",
        "pt_pt",
        "de_de",
    },
    spelloptions = {
        "camel",
    },

    -- Text --
    clipboard = vim.opt.clipboard + "unnamedplus",  -- copy paste operations to the system clipboard
    conceallevel = 0,       -- show text with "conceal" syntax
    fileencoding = "utf-8", -- encoding written to a file
    guifont = "monospace:h17",    -- font used on the GUI version of Neovim

    -- Tabs
    expandtab = true,       -- in insert mode convert tab to spaces
    shiftwidth = 4,         -- the number of spaces inserted for each indentation
    tabstop = 4,            -- insert 2 spaces for a tab

    -- Theme --
    termguicolors = true,   -- set term GUI colors (most terminals support this)
    cursorline = true,      -- highlight the current line

    -- Search --
    hlsearch = true,        -- highlight all matches on search pattern
    ignorecase = true,      -- ignore case by default on search pattern
    incsearch = true,       -- show where pattern matches while typing search
    smartcase = true,       -- overwrite "ignorecase" if search pattern has upper character

    -- Window --
    cmdheight = 1,          -- number of lines to display for the command line
    cmdwinheight = 10,      -- number of lines to display for the command line window
    number = true,          -- enable number in lines
    numberwidth = 2,        -- change number column width
    pumheight = 10,         -- popup menu height
    relativenumber = true,  -- enable relative numbered lines
    scrolloff = 8,          -- minimal number of screen lines to keep above/below cursor
    showmode = false,       -- don't show current operations like -- INSERT --, this is handled by a plugin
    showtabline = 1,        -- show tab line on top modes
    signcolumn = "yes",     -- enable sign column left of the number column for symbols/signs
    sidescrolloff = 8,      -- minimal number of screen lines to keep right/left cursor
    splitbelow = true,      -- force all horizontal splits to go below current window
    splitright = true,      -- force all vertical splits to got to the right of window
    wildmode = "longest:full,full", -- command-line completion mode

    -- Indent and wrap lines --
    autoindent = true,      -- copy indent from current line when starting a new line
    breakindent = true,     -- every wrapped line will continue visually indented
    colorcolumn = "121",    -- color the column displaying the wrap limit
    smartindent = true,     -- smarter auto indent on new line
    whichwrap = vim.opt.whichwrap + "<,>,[,],h,l",  -- allow specified keys to move to previous/next line when the cursor is on the first/last character in the line
    wrap = false,           -- wrap lines who exceed visible line length
}

-- Set options.
for key, value in pairs( OPTIONS ) do
    vim.opt[key] = value
end
