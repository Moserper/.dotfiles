local wezterm = require 'wezterm'
local theme = require 'theme'
local keys = require 'keys'
local status = require 'status'
local config = {}

-- Register event handlers (status bar, etc.)
status.register()

-- Fonts
config.font = wezterm.font_with_fallback({
  -- "DroidSansM Nerd Font",
  "GeistMono Nerd Font",
})

config.font_size = 12
config.cell_width = 1.00 -- ≈ adjust-cell-width = "-1%"
config.line_height = 1.05 -- ≈ adjust-cell-height = "10%"

-- Colors
config.colors = theme.colors
config.default_cursor_style = "SteadyBlock" -- block + no blink

-- Mac option-as-alt
config.send_composed_key_when_left_alt_is_pressed = false
config.send_composed_key_when_right_alt_is_pressed = false
config.enable_csi_u_key_encoding = true
-- config.enable_kitty_keyboard = true

-- Non-Latin layout fix (Thai): Thai tone marks (่ ้ ๊ ๋) sit on physical keys like
-- J. They are combining/dead-key marks, so WezTerm's dead-key composition swallows the
-- FIRST Cmd+<key> press and strips the Cmd (SUPER) modifier — the raw event
-- `Char('\u{e48}')+SUPER` gets cooked to `Char('j')+NONE`, so `{key='j',mods='CMD'}`
-- never matches and a literal "j" leaks to the pane; the shortcut only fires on the 2nd
-- press. Disabling dead-key composition preserves the modifier so Cmd shortcuts fire
-- first-try. use_ime=false is required for use_dead_keys to take effect on macOS.
-- (Verified via debug_key_events: J under Thai = U+0E48 mai-ek, a combining mark.)
config.use_ime = false
config.use_dead_keys = false


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
