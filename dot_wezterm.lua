local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.color_scheme = "dayfox"
config.font = wezterm.font("JuliaMono")

config.hyperlink_rules = wezterm.default_hyperlink_rules()

table.insert(config.hyperlink_rules, {
	regex = [[(?i)splat-(\d+)]],
	format = "https://geckorobotics.atlassian.net/browse/SPLAT-$1",
})

config.enable_wayland = false
config.window_background_opacity = 0.93
config.window_decorations = "TITLE | RESIZE"

config.hide_tab_bar_if_only_one_tab = true
return config
