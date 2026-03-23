#!/usr/bin/env bash
# ── apply.sh — Rocko_DE v3 wallpaper + color apply ───────────
# Usage: apply.sh <path-to-wallpaper>

set -e

WALLPAPER="${1:-}"

if [[ -z "$WALLPAPER" ]]; then
    echo "Usage: apply.sh <wallpaper-path>"
    exit 1
fi

if [[ ! -f "$WALLPAPER" ]]; then
    echo "File not found: $WALLPAPER"
    exit 1
fi

# Set wallpaper via swww
swww img "$WALLPAPER" \
    --transition-type grow \
    --transition-pos "0.5,0.5" \
    --transition-duration 1.2 \
    --transition-fps 144

# Generate Matugen color scheme
matugen image "$WALLPAPER" \
    --mode dark \
    --json > ~/.cache/matugen/colors.json

# Notify Quickshell to reload colors (Colors.qml watches the file)
# Also apply GTK colors via Matugen templates if configured
matugen image "$WALLPAPER" \
    --mode dark \
    2>/dev/null || true

echo "✓ Wallpaper and colors applied"
