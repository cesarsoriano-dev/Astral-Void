#!/usr/bin/env bash

THEME_DIR="$HOME/.config/hyde/themes/Astral-Void"

hyprctl reload

killall waybar 2>/dev/null
waybar -c "$THEME_DIR/configs/waybar/config.jsonc" -s "$THEME_DIR/configs/waybar/style.css" &

makoctl reload 2>/dev/null || mako -c "$THEME_DIR/configs/mako/config" &

notify-send -a "HyDE Project" -i "$THEME_DIR/assets/icons/arch_galaxy.png" "Astral Void" "Tema espacial aplicado con éxito"
