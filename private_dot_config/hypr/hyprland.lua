---------------------
---- MY PROGRAMS ----
---------------------

-- Global (not `local`) so host-specific config in hosts.lua can reference them,
-- mirroring the old global `$terminal` / `$fileManager` / `$menu` variables.
Terminal = "ghostty"
FileManager = "dolphin"
Menu = "sherlock"

----------------
---- COLORS ----
----------------

-- Colors are generated dynamically by pywal-16 into ~/.config/hypr/colors.lua
local function read_pywal_colors()
	local path = (os.getenv("HOME") or "") .. "/.config/hypr/colors.lua"
	local chunk = loadfile(path)
	if not chunk then
		return {}
	end
	local ok, result = pcall(chunk)
	if ok and type(result) == "table" then
		return result
	end
	return {}
end

-- Compose an rgba() string from a pywal hex color (no '#') and a 2-digit alpha.
local function rgba(hex, alpha)
	if type(hex) ~= "string" or hex == "" then
		return nil
	end
	return "rgba(" .. hex .. alpha .. ")"
end

local wal = read_pywal_colors()
local activeBorderColor1 = rgba(wal.color9, "ee") or "rgba(38214Fee)"
local activeBorderColor2 = rgba(wal.color12, "ee") or "rgba(465554ee)"
local inactiveBorderColor = rgba(wal.foreground, "55") or "rgba(c0c2c255)"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- for dolphin to play nice with file associations
hl.env("XDG_MENU_PREFIX", "arch-")

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("EDITOR", "nvim")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 20,

		border_size = 2,

		col = {
			active_border = { colors = { activeBorderColor1, activeBorderColor2 }, angle = 45 },
			inactive_border = inactiveBorderColor,
		},

		resize_on_border = false,

		allow_tearing = false,

		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 0.9,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
			color_inactive = inactiveBorderColor,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,

			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})

-- Bezier curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},
})

---------------
---- INPUT ----
---------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",

		follow_mouse = 1,

		accel_profile = "flat",
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		repeat_delay = 200,
		repeat_rate = 50,

		touchpad = {
			natural_scroll = false,
			scroll_factor = 0.97,
		},
	},
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- applications
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd("uwsm app -- " .. Terminal))
hl.bind(mainMod .. " + n", hl.dsp.exec_cmd("uwsm app -- " .. FileManager))
hl.bind(mainMod .. " + d", hl.dsp.exec_cmd("uwsm app -- " .. Menu))
hl.bind(mainMod .. " + w", hl.dsp.exec_cmd("uwsm app -- vivaldi"))
hl.bind("CTRL + SHIFT + 4", hl.dsp.exec_cmd("hyprshot --freeze --mode=region --raw --clipboard-only | swappy -f -"))
hl.bind("CTRL + SHIFT + 3", hl.dsp.exec_cmd("hyprshot -m window -m active --raw --clipboard-only | swappy -f -"))
hl.bind(mainMod .. " + CTRL + SHIFT + l", hl.dsp.exec_cmd("dm-tool switch-to-greeter"))
hl.bind(mainMod .. " + i", hl.dsp.exec_cmd("rofimoji --action clipboard"))
hl.bind(mainMod .. " + SHIFT + o", hl.dsp.exec_cmd("systemctl suspend"))
-- dpms-off crashes Hyprland on NVIDIA (Aquamarine dispatchIdle SIGSEGV); restore when fixed
-- hl.bind(mainMod .. " + SHIFT + o", hl.dsp.exec_cmd("sleep 1 && hyprctl dispatch 'hl.dsp.dpms(\"off\")'"))

hl.bind(mainMod .. " + q", hl.dsp.window.close())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + code:51", hl.dsp.layout("togglesplit")) -- pipe key (|)
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + f", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Move focus with mainMod + hjkl
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + code:114", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + code:113", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + code:111", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + code:116", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({ match = { fullscreen = true }, border_color = "rgb(FF0000)" })
hl.window_rule({ match = { class = "darktable" }, tag = "+opaque" })
hl.window_rule({ match = { fullscreen = true }, opacity = "1 override" })
hl.window_rule({ match = { fullscreen = false }, opacity = "1" })
hl.window_rule({ match = { tag = "opaque" }, opacity = "1 override" })

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

--------------------------
---- HOST-SPECIFIC CFG ----
--------------------------

require("hosts")
