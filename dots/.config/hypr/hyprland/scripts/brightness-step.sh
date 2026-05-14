#!/usr/bin/env bash
set -eu

# Adjust laptop screen brightness with resilient device selection.
# - Tries AMD/Intel/ACPI preferred names first (hybrid systems)
# - Falls back to any available backlight device
#
# Usage:
#   brightness-step.sh up   [percent]
#   brightness-step.sh down [percent]
# percent defaults to 5%

ACTION="${1:-up}"
STEP="${2:-5%}"

if [[ "$ACTION" != "up" && "$ACTION" != "down" ]]; then
  echo "Usage: $0 <up|down> [step-percent]" >&2
  exit 1
fi

case "$ACTION" in
  up)
    OP="${STEP}+"
    ;;
  down)
    OP="${STEP}-"
    ;;
 esac

mapfile -t ALL_DEVICES < <(
  brightnessctl -l 2>/dev/null | awk -F "'" "/Device .*class 'backlight'/ { print \$2 }"
)

if (( ${#ALL_DEVICES[@]} == 0 )); then
  echo "No backlight devices found" >&2
  exit 1
fi

ordered=()
add_unique() {
  local d="$1"
  for existing in "${ordered[@]}"; do
    [[ "$existing" == "$d" ]] && return 0
  done
  ordered+=("$d")
}

# Preferred backlight stack for this system family
for dev in "${ALL_DEVICES[@]}"; do
  case "$dev" in
    amdgpu_bl*|amdgpufb*|intel_backlight|acpi_video*)
      add_unique "$dev"
      ;;
  esac
done

# Fallbacks (e.g. nvidia_*)
for dev in "${ALL_DEVICES[@]}"; do
  add_unique "$dev"
done

for dev in "${ordered[@]}"; do
  if brightnessctl -d "$dev" set "$OP" >/dev/null 2>&1; then
    exit 0
  fi
done

exit 1
