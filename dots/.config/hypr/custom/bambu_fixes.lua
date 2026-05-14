-- Optional BambuStudio XWayland fixes backported from live custom/bambu-fixes.conf.
-- Not required by hyprland.lua by default; require("custom.bambu_fixes") manually
-- from custom/rules.lua if you want these active.

hl.config({
    xwayland = {
        force_zero_scaling = true,
        use_nearest_neighbor = false
    }
})

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("GDK_SCALE", "1")
hl.env("XCURSOR_SIZE", "24")

hl.window_rule({ match = { class = "^(bambustu)" }, immediate = true })
hl.window_rule({ match = { class = "^(bambustu)" }, no_blur = true })
hl.window_rule({ match = { class = "^(bambustu)" }, no_shadow = true })
hl.window_rule({ match = { class = "^(bambustu)" }, force_rgbx = true })
hl.window_rule({ match = { class = "^(bambustu)" }, rounding = 0 })
hl.window_rule({ match = { class = "^(bambustu)" }, no_anim = true })
hl.window_rule({ match = { class = "^(bambustu)" }, no_border = true })
