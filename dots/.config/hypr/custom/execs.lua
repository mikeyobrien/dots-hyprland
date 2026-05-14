-- Local live-config backport from ~/.config/hypr/custom/execs.conf

hl.on("hyprland.start", function()
    -- The live legacy config referenced ~/.config/hypr/scripts/monitor-switch.sh,
    -- but that script is not present in the current live tree. Do not preserve
    -- that missing startup hook in the repo-backed Lua config.

    -- Wallpaper
    hl.exec_cmd("hyprpaper")
end)
