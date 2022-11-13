-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/henry/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/henry/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/henry/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/henry/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/henry/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n<\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\fcomment\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    load_after = {},
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["Telescope-media-files.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/Telescope-media-files.nvim",
    url = "https://github.com/nvim-telescope/Telescope-media-files.nvim"
  },
  ["alpha-nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["bufferline.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
  },
  ["cmp-buffer"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-buffer/after/plugin/cmp_buffer.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-calc"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-calc/after/plugin/cmp_calc.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-calc",
    url = "https://github.com/hrsh7th/cmp-calc"
  },
  ["cmp-cmdline"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-cmdline/after/plugin/cmp_cmdline.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-emoji"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-emoji/after/plugin/cmp_emoji.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-git"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/cmp-git",
    url = "https://github.com/petertriho/cmp-git"
  },
  ["cmp-npm"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/cmp-npm",
    url = "https://github.com/David-Kunz/cmp-npm"
  },
  ["cmp-nvim-lsp"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp/after/plugin/cmp_nvim_lsp.lua" },
    config = { "\27LJ\2\nA\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\17cmp-nvim-lsp\17G_PlugLL_Dir\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-document-symbol"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-document-symbol/after/plugin/cmp_nvim_lsp_document_symbol.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-document-symbol",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-document-symbol"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help/after/plugin/cmp_nvim_lsp_signature_help.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua/after/plugin/cmp_nvim_lua.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-path/after/plugin/cmp_path.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-spell"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-spell/after/plugin/cmp-spell.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  ["cmp-treesitter"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-treesitter/after/plugin/cmp_treesitter.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp-treesitter",
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  cmp_luasnip = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp_luasnip/after/plugin/cmp_luasnip.lua" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["copilot-cmp"] = {
    config = { "\27LJ\2\n@\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\16cmp-copilot\17G_PlugLL_Dir\frequire\0" },
    load_after = {
      ["copilot.lua"] = true,
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/copilot-cmp",
    url = "https://github.com/zbirenbaum/copilot-cmp"
  },
  ["copilot.lua"] = {
    after = { "copilot-cmp" },
    config = { "\27LJ\2\n<\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\fcopilot\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["crates.nvim"] = {
    after_files = { "/home/henry/.local/share/nvim/site/pack/packer/opt/crates.nvim/after/plugin/cmp_crates.lua" },
    config = { "\27LJ\2\n4\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\vcrates\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/crates.nvim",
    url = "https://github.com/saecki/crates.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n=\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\rgitsigns\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "https://github.com/ellisonleao/gruvbox.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n>\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\14blankline\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["link-visitor.nvim"] = {
    config = { "\27LJ\2\nA\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\17link-visitor\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/link-visitor.nvim",
    url = "https://github.com/xiyaowong/link-visitor.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["marks.nvim"] = {
    config = { "\27LJ\2\n:\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\nmarks\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/marks.nvim",
    url = "https://github.com/chentoast/marks.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n>\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\14autopairs\17G_PlugLL_Dir\frequire\0" },
    load_after = {
      ["nvim-cmp"] = true
    },
    loaded = false,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    after = { "cmp_luasnip", "cmp-nvim-lsp-document-symbol", "cmp-path", "cmp-treesitter", "cmp-nvim-lua", "cmp-buffer", "cmp-calc", "cmp-emoji", "cmp-nvim-lsp", "cmp-cmdline", "copilot-cmp", "cmp-nvim-lsp-signature-help", "nvim-autopairs", "cmp-spell" },
    config = { "\27LJ\2\n8\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\bcmp\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n>\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\14colorizer\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n>\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\14nvim-tree\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["project.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["sqlite.lua"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/sqlite.lua",
    url = "https://github.com/kkharji/sqlite.lua"
  },
  tagbar = {
    config = { "\27LJ\2\n;\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\vtagbar\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/tagbar",
    url = "https://github.com/majutsushi/tagbar"
  },
  ["telescope-frecency.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/telescope-frecency.nvim",
    url = "https://github.com/nvim-telescope/telescope-frecency.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-luasnip.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/telescope-luasnip.nvim",
    url = "https://github.com/benfowler/telescope-luasnip.nvim"
  },
  ["telescope-menu.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/telescope-menu.nvim",
    url = "https://github.com/octarect/telescope-menu.nvim"
  },
  ["telescope-repo.nvim"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/telescope-repo.nvim",
    url = "https://github.com/cljoly/telescope-repo.nvim"
  },
  ["telescope-tabs"] = {
    loaded = true,
    path = "/home/henry/.local/share/nvim/site/pack/packer/start/telescope-tabs",
    url = "https://github.com/LukasPietzschmann/telescope-tabs"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n>\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\14telescope\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\nB\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\18todo-comments\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { "\27LJ\2\n?\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\15toggleterm\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["vim-illuminate"] = {
    config = { "\27LJ\2\n?\0\0\4\0\3\0\0066\0\0\0006\2\1\0'\3\2\0&\2\3\2B\0\2\1K\0\1\0\15illuminate\17G_PlugLL_Dir\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-surround"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  vimtex = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/henry/.local/share/nvim/site/pack/packer/opt/vimtex",
    url = "https://github.com/lervag/vimtex"
  }
}

time([[Defining packer_plugins]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd plenary.nvim ]]
vim.cmd [[ packadd popup.nvim ]]
vim.cmd [[ packadd friendly-snippets ]]
time([[Sequenced loading]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufWinEnter * ++once lua require("packer.load")({'nvim-colorizer.lua', 'todo-comments.nvim', 'link-visitor.nvim', 'indent-blankline.nvim'}, { event = "BufWinEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead *.latex ++once lua require("packer.load")({'vimtex'}, { event = "BufRead *.latex" }, _G.packer_plugins)]]
vim.cmd [[au BufRead *.tex ++once lua require("packer.load")({'vimtex'}, { event = "BufRead *.tex" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'copilot.lua', 'vim-illuminate', 'nvim-cmp', 'LuaSnip'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead *.toml ++once lua require("packer.load")({'rust-tools.nvim'}, { event = "BufRead *.toml" }, _G.packer_plugins)]]
vim.cmd [[au BufRead Cargo.toml ++once lua require("packer.load")({'crates.nvim'}, { event = "BufRead Cargo.toml" }, _G.packer_plugins)]]
vim.cmd [[au CursorMoved * ++once lua require("packer.load")({'vim-surround', 'Comment.nvim'}, { event = "CursorMoved *" }, _G.packer_plugins)]]
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'tagbar', 'nvim-tree.lua', 'toggleterm.nvim', 'telescope.nvim', 'marks.nvim', 'gitsigns.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead *.rs ++once lua require("packer.load")({'rust-tools.nvim'}, { event = "BufRead *.rs" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
