local wezterm = require 'wezterm'
local act = wezterm.action

-- Pass Shift-Enter through for whitelisted apps; swallow elsewhere
-- Add more process names here to expand the whitelist
local shift_enter_whitelist = { 'tmux' }

return {
  -- {
  --   key = "j",
  --   mods = "CTRL",
  --   action = act.SendKey { key = "j", mods = "CTRL" },
  -- },
  { key = 'c', mods = 'CMD', action = act.CopyTo 'Clipboard' },
  -- ⌘V → Paste from Clipboard
  { key = 'v', mods = 'CMD', action = act.PasteFrom 'Clipboard' },

  -- Option+Arrow for jumping words
  { key = 'LeftArrow', mods = 'OPT', action = act.SendKey { key = 'LeftArrow', mods = 'ALT' } },
  { key = 'RightArrow', mods = 'OPT', action = act.SendKey { key = 'RightArrow', mods = 'ALT' } },

  {
    key = 'Enter',
    mods = 'SHIFT',
    action = wezterm.action_callback(function(win, pane)
      local proc = pane:get_foreground_process_name() or ''
      local allowed = false
      for _, name in ipairs(shift_enter_whitelist) do
        if proc:match(name) then allowed = true; break end
      end
      if allowed then
        win:perform_action(act.SendKey { key = 'Enter', mods = 'SHIFT' }, pane)
      end
      -- otherwise: swallow the key (do nothing)
    end),
  },

  -- -- Option+Backspace for deleting words
  -- { key = 'Backspace', mods = 'OPT', action = act.SendKey { key = 'w', mods = 'ALT' } },
}
