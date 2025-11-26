local wezterm = require("wezterm")

wezterm.add_to_config_reload_watch_list("/home/darwin/.cache/wal/wezterm-pywal.toml")
wezterm.add_to_config_reload_watch_list("/home/darwin/.config/wezterm/colors/wezterm-pywal.toml")

local config = wezterm.config_builder()

-- f
config.color_scheme = "wezterm-pywal"
-- config.color_scheme = "dayfox"

config.font = wezterm.font("JuliaMono")
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
	regex = [[(?i)splat-(\d+)]],
	format = "https://geckorobotics.atlassian.net/browse/SPLAT-$1",
})

config.enable_wayland = true
-- config.window_background_opacity = 0.80
config.window_background_opacity = 0.90
config.window_decorations = "TITLE | RESIZE"
config.hide_tab_bar_if_only_one_tab = true

return config
