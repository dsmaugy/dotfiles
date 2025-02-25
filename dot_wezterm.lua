local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.color_scheme = "dayfox"
-- config.font = wezterm.font("FiraMono Nerd Font Mono")
config.font = wezterm.font("JuliaMono")
-- config.font_size = 13.0

config.hyperlink_rules = wezterm.default_hyperlink_rules()

table.insert(config.hyperlink_rules, {
	regex = [[(?i)splat-(\d+)]],
	format = "https://geckorobotics.atlassian.net/browse/SPLAT-$1",
})
return config
