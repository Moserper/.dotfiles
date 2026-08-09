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

  -- ⌥` → type a LITERAL backtick. A bare ` can't do this: tmux's prefix is `, and
  -- `bind-key ` last-window` means pressing it twice switches windows, not emits `.
  -- tmux's escape hatch is `bind-key e send-prefix`, so inside tmux we send prefix (`)
  -- then `e` to emit one real backtick. Outside tmux, just send ` directly.
  -- phys:Grave matches by physical position so it still fires under the Thai layout
  -- (see the phys:J note below re: WezTerm stripping modifiers off cooked Thai events).
  {
    key = 'phys:Grave',
    mods = 'OPT',
    action = wezterm.action_callback(function(win, pane)
      local proc = pane:get_foreground_process_name() or ''
      if proc:match 'tmux' then
        win:perform_action(act.Multiple {
          act.SendKey { key = '`' }, -- tmux prefix
          act.SendKey { key = 'e' }, -- bind-key e send-prefix → literal `
        }, pane)
      else
        win:perform_action(act.SendKey { key = '`' }, pane)
      end
    end),
  },

  {
    key = 'Enter',
    mods = 'SHIFT',
    action = wezterm.action_callback(function(win, pane)
      -- local proc = pane:get_foreground_process_name() or ''
      -- local allowed = false
      -- for _, name in ipairs(shift_enter_whitelist) do
      --   if proc:match(name) then allowed = true; break end
      -- end
      -- if
      --   win:perform_action(act.SendKey { key = 'Enter', mods = 'SHIFT' }, pane)
      -- end
      -- -- otherwise: swallow the key (do nothing)

      win:perform_action(act.SendKey { key = 'Enter', mods = 'SHIFT' }, pane)
    end),
  },

  -- -- Option+Backspace for deleting words
  -- { key = 'Backspace', mods = 'OPT', action = act.SendKey { key = 'w', mods = 'ALT' } },

  -- ⌘J → fuzzy pane switcher. tmux can't see Cmd, so forward prefix+j (prefix =
  -- backtick) → tmux `bind j` opens tmux-switch in a display-popup.
  -- Guarded to tmux only: outside tmux, Cmd+J is swallowed (no stray "`j" typed).
  {
    key = 'phys:J', -- physical key, not the layout char: under Thai, J = ่ (mai-ek, a
    mods = 'CMD',   -- combining mark) and WezTerm strips CMD off the cooked event, so
                    -- key='j' never matches. phys:J matches the raw event (mods intact).
    action = wezterm.action_callback(function(win, pane)
      local proc = pane:get_foreground_process_name() or ''
      if proc:match 'tmux' then
        win:perform_action(act.Multiple {
          act.SendKey { key = '`' }, -- tmux prefix
          act.SendKey { key = 'j' }, -- bound to display-popup → tmux-switch
        }, pane)
      end
    end),
  },

  -- ⌘R → restore a saved maw group. tmux can't see Cmd, so forward prefix+k
  -- (prefix = backtick) → tmux `bind k` opens `maw restore --pick` in a popup.
  -- NB the forwarded key is `k`, NOT `r`: tmux's `bind r` is reload-config, so we keep
  -- the internal key on `k` and only move the Mac accelerator to ⌘R (it needn't match).
  -- Guarded to tmux only: outside tmux, ⌘R falls through to WezTerm's default.
  --
  -- TWO entries needed for ⌘R (unlike ⌘J/⌘G): WezTerm has a built-in `SUPER r ->
  -- ReloadConfiguration` on the *mapped* char, and mapped is matched BEFORE physical,
  -- so it shadows phys:R in EN layout. `key='r'` overrides that default for EN; `phys:R`
  -- catches Thai (where the mapped char is พ + the CMD modifier is stripped, see phys:J).
  {
    key = 'r', -- mapped char (EN) — overrides WezTerm's default ReloadConfiguration
    mods = 'CMD',
    action = wezterm.action_callback(function(win, pane)
      local proc = pane:get_foreground_process_name() or ''
      if proc:match 'tmux' then
        win:perform_action(act.Multiple {
          act.SendKey { key = '`' }, -- tmux prefix
          act.SendKey { key = 'k' }, -- tmux `bind k` → display-popup → maw restore --pick
        }, pane)
      end
    end),
  },
  {
    key = 'phys:R', -- physical key (Thai layout; see phys:J note above)
    mods = 'CMD',
    action = wezterm.action_callback(function(win, pane)
      local proc = pane:get_foreground_process_name() or ''
      if proc:match 'tmux' then
        win:perform_action(act.Multiple {
          act.SendKey { key = '`' }, -- tmux prefix
          act.SendKey { key = 'k' }, -- tmux `bind k` → display-popup → maw restore --pick
        }, pane)
      end
    end),
  },

  -- ⌘G → lazygit for the current pane's repo, in OR out of tmux.
  --   inside tmux: tmux can't see Cmd, so forward prefix+g (prefix = backtick) →
  --                tmux `bind g` opens lazygit in a display-popup.
  --   outside tmux: WezTerm spawns lazygit itself, in a new tab rooted at the pane's cwd.
  {
    key = 'phys:G', -- physical key (see phys:J note above re: Thai layout)
    mods = 'CMD',
    action = wezterm.action_callback(function(win, pane)
      local proc = pane:get_foreground_process_name() or ''
      if proc:match 'tmux' then
        win:perform_action(act.Multiple {
          act.SendKey { key = '`' }, -- tmux prefix
          act.SendKey { key = 'g' }, -- tmux `bind g` → display-popup → lazygit
        }, pane)
      else
        -- get_current_working_dir() returns a Url (newer WezTerm) or a string; normalise.
        local cwd = pane:get_current_working_dir()
        if type(cwd) == 'userdata' then cwd = cwd.file_path end
        -- absolute path: WezTerm spawns directly (not via login shell), so its PATH lacks
        -- /opt/homebrew/bin. The tmux popup works because it inherits the server's env.
        win:perform_action(act.SpawnCommandInNewTab { args = { '/opt/homebrew/bin/lazygit' }, cwd = cwd }, pane)
      end
    end),
  },

  -- ⌘E → open the editor at the CURRENT pane's path. tmux can't see Cmd, so forward
  -- prefix+C-e (prefix = backtick) → tmux `bind C-e` run-shell → the zsh alias `c`.
  -- NB the forwarded key is C-e, NOT e: tmux's `bind e` is send-prefix (the literal-backtick
  -- hatch, see the ⌥` binding above), so `e` is already taken — only the Mac accelerator is
  -- on ⌘E, and it needn't match the internal key (same trick as ⌘R → prefix+k).
  -- Guarded to tmux only, like ⌘J/⌘R: outside tmux, ⌘E is swallowed (no stray "`" typed).
  {
    key = 'phys:E', -- physical key (see phys:J note above re: Thai layout). ONE entry is
    mods = 'CMD',   -- enough, unlike ⌘R: WezTerm has no built-in SUPER-e to shadow phys:E.
    action = wezterm.action_callback(function(win, pane)
      local proc = pane:get_foreground_process_name() or ''
      if proc:match 'tmux' then
        win:perform_action(act.Multiple {
          act.SendKey { key = '`' }, -- tmux prefix
          act.SendKey { key = 'e', mods = 'CTRL' }, -- tmux `bind C-e` → run-shell → editor
        }, pane)
      end
    end),
  },

  -- ⌘O → copy the current window's "<seq>:<window-name>" to clipboard. tmux can't
  -- see Cmd, so forward prefix+y (prefix = backtick) → tmux `bind y` run-shell → pbcopy.
  -- Internal key is y (yank mnemonic), NOT o — plain o/C-o/M-o are tmux defaults (pane
  -- cycle / window rotate), same "Mac accelerator needn't match internal key" trick as
  -- ⌘R → prefix+k. Guarded to tmux only, like ⌘J/⌘R/⌘E: outside tmux, ⌘O is swallowed.
  {
    key = 'phys:O', -- physical key (see phys:J note above re: Thai layout). ONE entry is
    mods = 'CMD',   -- enough: `wezterm show-keys --lua` has no built-in SUPER-o to shadow it.
    action = wezterm.action_callback(function(win, pane)
      local proc = pane:get_foreground_process_name() or ''
      if proc:match 'tmux' then
        win:perform_action(act.Multiple {
          act.SendKey { key = '`' }, -- tmux prefix
          act.SendKey { key = 'y' }, -- tmux `bind y` → run-shell → pbcopy
        }, pane)
      end
    end),
  },
}
