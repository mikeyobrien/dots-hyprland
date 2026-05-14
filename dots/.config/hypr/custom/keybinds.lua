-- Local live-config backport from ~/.config/hypr/custom/keybinds.conf

hl.bind("CTRL + SUPER + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/illogical-impulse/config.json"),
    { description = "Edit shell config" })
hl.bind("CTRL + SUPER + ALT + Slash", hl.dsp.exec_cmd("xdg-open ~/.config/hypr/custom/keybinds.lua"),
    { description = "Edit user keybinds" })

-- Brightness controls with AMD/NVIDIA fallback script from the live config.
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("~/.config/hypr/hyprland/scripts/brightness-step.sh up"),
    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/hypr/hyprland/scripts/brightness-step.sh down"),
    { locked = true, repeating = true })

-- The live legacy config had Super+Shift+M/N bindings for
-- ~/.config/hypr/scripts/monitor-switch.sh, but that script is not present.
