local M = "SUPER"

-- ══════════════════════════════════════════
--  AUTOSTART
-- ══════════════════════════════════════════

hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia")
end)

-- ══════════════════════════════════════════
--  MONITORS
-- ══════════════════════════════════════════

hl.monitor({
  output   = "DP-2",
  mode     = "2560x1440@240.00Hz",
  position = "1920x0",
  scale    = 1,
})

hl.monitor({
  output   = "HDMI-A-1",
  mode     = "1920x1080@60",
  position = "0x180",
  scale    = 1,
})

hl.monitor({
  output   = "eDP-1",
  mode     = "1920x1080",
  position = "1920x0",
  scale    = 1.25,
})

-- ══════════════════════════════════════════
--  ENVIRONMENT
-- ══════════════════════════════════════════

hl.env("XKB_DEFAULT_LAYOUT", "be")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- ══════════════════════════════════════════
--  GENERAL CONFIG
-- ══════════════════════════════════════════

hl.config({
  general = {
    gaps_in      = 2,
    gaps_out     = 4,
    border_size  = 2,
    col = {
      active_border   = "rgba(ffffff60)",
      inactive_border = "rgba(ffffff00)",
    },
    resize_on_border = true,
    allow_tearing    = true,
    layout           = "scrolling",
  },

  decoration = {
    rounding       = 10,
    rounding_power = 2,
    active_opacity   = 1.0,
    inactive_opacity = 1.0,
    shadow = {
      enabled = false,
    },
    blur = {
      enabled   = true,
      size      = 3,
      passes    = 2,
      vibrancy  = 0.6,
    },
  },

  animations = {
    enabled = true,
  },

  input = {
    kb_layout    = "be",
    follow_mouse = 1,
    mouse_refocus = false,
    sensitivity  = 0,
    touchpad = {
      natural_scroll        = true,
      tap_to_click          = true,
      scroll_factor         = 1.0,
      drag_lock             = true,
    },
    accel_profile = "flat",
  },

  misc = {
    disable_hyprland_logo    = true,
    disable_splash_rendering = true,
    focus_on_activate        = true,
  },

  dwindle = {
    preserve_split = true,
  },

  scrolling = {
    fullscreen_on_one_column = false,
    column_width = 1.0,
    explicit_column_widths = "0.33333, 0.5, 0.66667, 1.0"
  },
})

-- ══════════════════════════════════════════
--  ANIMATIONS
-- ══════════════════════════════════════════

hl.curve("custom_spring", { type = "spring", mass = 1, stiffness = 1400, dampening = 90 })

hl.animation({ leaf = "fade", enabled = false })
hl.animation({ leaf = "layers", enabled = false })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, spring = "custom_spring", style = "slidevert" })
hl.animation({ leaf = "windows",    enabled = true, speed = 1, spring = "custom_spring", style = "slide" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 1, spring = "custom_spring", style = "popin 90%" })

-- ══════════════════════════════════════════
--  WINDOW RULES
-- ══════════════════════════════════════════

hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
})

for _, class in ipairs({ "kitty", "org.gnome.Nautilus" }) do
  hl.window_rule({
    match            = { class = class },
    opacity = "0.85",
  })
end

local float_sized = {
  { class = "org.gnome.Nautilus" },
  { class = "dev.noctalia.Noctalia.Settings" },
}
for _, rule in ipairs(float_sized) do
  hl.window_rule({
    match   = { class = rule.class },
    float   = true,
    size  = "monitor_w*0.5 monitor_h*0.66",
  })
end

for _, class in ipairs({"net-runelite-client-RuneLite" }) do
  hl.window_rule({ match = { class = class }, float = true })
end

-- ══════════════════════════════════════════
--  LAYER RULES
-- ══════════════════════════════════════════

hl.layer_rule({
  name = "noctalia",
  match = {
    namespace = "^noctalia-(bar-.+|notification|dock|panel|osd)$",
  },
  no_anim = true,
  blur_popups = true,
})

-- ══════════════════════════════════════════
--  LAYOUT TOGGLE  (Super+Tab)
-- ══════════════════════════════════════════

local function toggle_layout()
  if hl.get_config("general.layout") == "scrolling" then
    hl.config({ general = { layout = "dwindle" } })
  else
    hl.config({ general = { layout = "scrolling" } })
  end
end

-- ══════════════════════════════════════════
--  GESTURES
-- ══════════════════════════════════════════

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })

-- ══════════════════════════════════════════
--  KEY BINDINGS
-- ══════════════════════════════════════════

-- vim-key passthrough (Alt+hjkl and AltGr+hjkl → arrow keys)
for _, mod in ipairs({ "ALT", "ISO_Level3_Shift" }) do
  hl.bind(mod .. " + h", hl.dsp.exec_cmd("wtype -k Left"))
  hl.bind(mod .. " + l", hl.dsp.exec_cmd("wtype -k Right"))
  hl.bind(mod .. " + j", hl.dsp.exec_cmd("wtype -k Down"))
  hl.bind(mod .. " + k", hl.dsp.exec_cmd("wtype -k Up"))
end

-- Window / session
hl.bind(M .. " + Q",                hl.dsp.window.close())
hl.bind(M .. " + CTRL + SHIFT + Q", hl.dsp.window.kill())
hl.bind(M .. " + BackSpace",        hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
hl.bind(M .. " + W",                hl.dsp.window.float({ action = "toggle" }))
hl.bind("CTRL + ALT + Return",      hl.dsp.window.fullscreen())
hl.bind("ALT + TAB",                hl.dsp.exec_cmd("noctalia msg window-switcher"))
hl.bind(M .. " + TAB",              toggle_layout)

-- App launchers
hl.bind(M .. " + T",         hl.dsp.exec_cmd("kitty"))
hl.bind(M .. " + F",         hl.dsp.exec_cmd("helium"))
hl.bind(M .. " + E",         hl.dsp.exec_cmd("emacsclient -c -a ''"))
hl.bind(M .. " + A",         hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(M .. " + X",         hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"))
hl.bind(M .. " + C",         hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(M .. " + S",         hl.dsp.exec_cmd(
  "grep '^Host ' ~/.ssh/config | grep -v '\\*' | awk '{print $2}' | noctalia dmenu | xargs -I{} kitty ssh {}"
))

-- Screenshots
hl.bind(M .. " + P",         hl.dsp.exec_cmd("noctalia msg screenshot-region"),     { repeat_key = false })
hl.bind(M .. " + SHIFT + P", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"), { repeat_key = false })

hl.bind(M .. " + ALT + P", function()
  hl.exec_cmd(
    "sh -c 'wl-mirror --fullscreen-output " ..
    "$(hyprctl -j monitors | jq -r \".[].name\" | " ..
    "grep -v $(hyprctl -j activeworkspace | jq -r \".monitor\") | noctalia dmenu ) " ..
    "$(hyprctl -j activeworkspace | jq -r \".monitor\")'"
  )
end, { repeat_key = false })

-- Media / brightness
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("noctalia msg volume-up"),       { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("noctalia msg volume-down"),     { locked = true, repeating = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("noctalia msg volume-mute"),     { locked = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("noctalia msg brightness-up"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("noctalia msg brightness-down"), { locked = true, repeating = true })
hl.bind("XF86AudioPlay",          hl.dsp.exec_cmd("noctalia msg media toggle"),    { locked = true })
hl.bind("XF86AudioPause",         hl.dsp.exec_cmd("noctalia msg media toggle"),    { locked = true })
hl.bind("XF86AudioNext",          hl.dsp.exec_cmd("noctalia msg media next"),      { locked = true })
hl.bind("XF86AudioPrev",          hl.dsp.exec_cmd("noctalia msg media previous"),  { locked = true })

for _, d in ipairs({
  { key = "H", arrow = "Left",  selector = { direction = "l" }, ctrl_selector = { monitor = "+1"  }},
  { key = "L", arrow = "Right", selector = { direction = "r" }, ctrl_selector = { monitor = "-1"  }},
  { key = "K", arrow = "Up",    selector = { direction = "u" }, ctrl_selector = { workspace = "r-1" }},
  { key = "J", arrow = "Down",  selector = { direction = "d" }, ctrl_selector = { workspace = "r+1" }},
}) do
  for _, k in ipairs({ d.key, d.arrow }) do
    hl.bind(M .. " + " .. k,               hl.dsp.focus(d.selector))
    hl.bind(M .. " + CTRL + " .. k,        hl.dsp.focus(d.ctrl_selector))
    hl.bind(M .. " + ALT + " .. k,         hl.dsp.window.move(d.selector))
    hl.bind(M .. " + CTRL + ALT + " .. k,  hl.dsp.window.move(d.ctrl_selector))
  end
end

-- Column / window sizing
hl.bind(M .. " + R",         hl.dsp.layout("colresize +conf"))
hl.bind(M .. " + SHIFT + R", hl.dsp.layout("colresize -conf"))
-- hl.bind(M .. " + Minus",     hl.dsp.layout("set_width -10%"))
-- hl.bind(M .. " + Equal",     hl.dsp.layout("set_width +10%"))

-- Mouse drag / resize
hl.bind(M .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(M .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
