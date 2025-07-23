local wezterm = require("wezterm")
local M = {}

function M.apply_to_config(config)
	-- color scheme
	config.color_scheme_dirs = { wezterm.config_dir .. "/colors" }
	config.color_scheme = "tokyonight_night"
	config.window_background_image = wezterm.config_dir .. "/background.jpg"
	config.window_background_image_hsb = {
		brightness = 0.3,
		hue = 1.0,
		saturation = 1.0,
	}
	-- For example, changing the initial geometry for new windows:
	config.initial_cols = 120
	config.initial_rows = 28

	-- or, changing the font size and color scheme.
	config.font = wezterm.font({
		family = "JetBrains Mono",
		harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	})
	config.font_size = 12
	config.window_background_opacity = 0.8
	config.text_background_opacity = 1
	config.macos_window_background_blur = 20

	-- Tab bar
	config.use_fancy_tab_bar = true
	-- config.tab_bar_at_bottom = true

	-- windows
	config.window_frame = {
		font = wezterm.font({ family = "Roboto", weight = "Bold" }),
		font_size = 12.0,
	}

	config.window_padding = { left = 2, right = 2, top = 0, bottom = 0 }

	config.colors = { tab_bar = { inactive_tab_edge = "#575757" } }

	config.inactive_pane_hsb = {
		saturation = 0.8,
		brightness = 0.3,
	}
end

return M
