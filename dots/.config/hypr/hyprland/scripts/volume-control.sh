#!/usr/bin/env bash
# Volume hotkeys: PipeWire + PCM-only ALSA fallback
# Usage: volume-control.sh up|down|mute|micmute

set -euo pipefail

ACTION="${1:-}"

# Find built-in Realtek/ALC card for PCM control (defaults to card 1 if detected path fails)
ALSA_CARD="1"
for cpath in /proc/asound/card*/codec*; do
    if grep -q -E "Realtek|ALC|Ryzen" "$cpath" 2>/dev/null; then
        ALSA_CARD="${cpath%%/codec*}"
        ALSA_CARD="${ALSA_CARD#/proc/asound/card}"
        break
    fi
done

has_pcm() {
    amixer -c "$ALSA_CARD" scontrols 2>/dev/null | grep -q "'PCM'"
}

set_pcm() {
    local delta="$1"
    if has_pcm; then
        amixer -c "$ALSA_CARD" sset "PCM" "$delta" >/dev/null 2>&1 || true
    fi
}

case "$ACTION" in
    up)
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+
        set_pcm 2%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-
        set_pcm 2%-
        ;;
    mute)
        if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]'; then
            wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        else
            wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
        fi
        ;;
    micmute)
        wpctl set-mute @DEFAULT_SOURCE@ toggle
        ;;
    *)
        echo "Usage: $0 up|down|mute|micmute"
        exit 1
        ;;
esac
