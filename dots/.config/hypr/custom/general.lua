-- Local live-config backport from ~/.config/hypr/custom/general.conf

-- Monitor profile automation from the live legacy config is intentionally not
-- enabled here: ~/.config/hypr/scripts/monitor-switch.sh is not present.
-- Keep display experiments in the lab branch before deploying to live config.

hl.config({
    input = {
        -- Remap Caps Lock to Ctrl
        kb_options = "ctrl:nocaps"
    },
    xwayland = {
        force_zero_scaling = true
    }
})
