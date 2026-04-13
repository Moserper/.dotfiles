local wezterm = require 'wezterm'
local theme = require 'theme'
local keys = require 'keys'
local status = require 'status'
local config = {}

-- Register event handlers (status bar, etc.)
status.register()

-- Fonts
config.font = wezterm.font_with_fallback({
  "DroidSansM Nerd Font",
})

config.font_size = 12
config.cell_width = 1.00 -- ≈ adjust-cell-width = "-1%"
config.line_height = 1.05 -- ≈ adjust-cell-height = "10%"

-- Colors
config.colors = theme.colors
config.default_cursor_style = "SteadyBlock" -- block + no blink

-- Mac option-as-alt
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.enable_csi_u_key_encoding = true
-- config.enable_kitty_keyboard = true


-- Key bindings
config.keys = keys

-- window
config.window_close_confirmation = "NeverPrompt"
config.show_update_window = true

-- -- hide title bar but keep resizable
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.max_fps = 120

-- initial window size
config.initial_rows = 40
config.initial_cols = 120


return config
