#!/usr/bin/env bash

WALLPAPER="$HOME/.config/hyde/themes/Astral-Void/assets/wallpapers/astral_void_main.jpg"

if command -v matugen &> /dev/null; then
    matugen image "$WALLPAPER" -m "dark"
elif command -v wal &> /dev/null; then
    wal -q -i "$WALLPAPER" -n
fi
