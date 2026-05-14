-- Local live-config backport from ~/.config/hypr/custom/rules.conf

-- Force XWayland apps to respect scaling
hl.window_rule({ match = { xwayland = 1 }, force_rgbx = true })

-- Battle.net launcher under Proton/UMU shows up as steam_app_default.
-- Keep only the launcher floating; do not apply this to launched games like Diablo IV.
hl.window_rule({ match = { class = "^(steam_app_default)$", title = "^(Battle\\.net.*)$" }, float = true })
hl.window_rule({ match = { class = "^(steam_app_default)$", title = "^(Battle\\.net.*)$" }, size = { 1200, 760 } })
hl.window_rule({ match = { class = "^(steam_app_default)$", title = "^(Battle\\.net.*)$" }, center = true })
