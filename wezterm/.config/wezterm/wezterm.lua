local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night Moon"
config.font = wezterm.font("Maple Mono NF")
config.font_size = 16
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.default_cursor_style = 'SteadyBar'

config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}

return config
