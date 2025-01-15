local wezterm = require("wezterm")

config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false, --disable tab bar at the top of the wezterm
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE", --disable title bar but enable the resizable border
	default_cursor_style = "BlinkingBar",
	color_scheme = "Dracula (Gogh)",
	font = wezterm.font("Hack Nerd Font", { weight = "Regular", stretch = "Normal", style = "Normal" }),
	font_size = 16,
	--background = {
	--  {
	--    souce = {
	--      Color  = "#282c35",
	--    },
	--    }
	--    width = 100%,
	--    height = 100%,
	--	opacity = 0.55,
	--},
	window_padding = {
		left = 3,
		right = 3,
		top = 0,
		bottom = 0,
	},
	keys = {
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		-- Make Option-Right equivalent to Alt-f; forward-word
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	},
}

return config
