local plugin = require("wezterm").plugin
local M = {}

local bar = plugin.require("https://github.com/adriankarlen/bar.wezterm")

function M.apply_to_config(config)
	bar.apply_to_config(config)
end

return M
