-- [ DIRECTORIES ] --
local ROOT_DIR = "user."
local CONFIGS_DIR = ROOT_DIR .. "configs."

-- [ GENERAL ] --
require( CONFIGS_DIR .. "settings" )        -- user defined global settings/variables
require( CONFIGS_DIR .. "builtin_options" ) -- vim built-in options, :help options
require( CONFIGS_DIR .. "leader_keymap" )   -- change leader keymap, must be loaded before plugin magnager
require( ROOT_DIR .. "plugin_manager" )
require( ROOT_DIR .. "autocmds" )

-- [ OVERWRITES ] --
require( CONFIGS_DIR .. "keymaps" )
