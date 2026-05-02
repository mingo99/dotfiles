local wezterm = require("wezterm")
local ui = require("ui")
local keys = require("keymaps")

local config = wezterm.config_builder()

ui.apply_to_config(config)
keys.apply_to_config(config)

return config
