local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.color_scheme = "dayfox"
-- config.font = wezterm.font("FiraMono Nerd Font Mono")
config.font = wezterm.font("JuliaMono")
-- config.font_size = 13.0
return config
