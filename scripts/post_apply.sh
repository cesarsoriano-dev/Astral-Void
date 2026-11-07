#!/usr/bin/env bash
# ==============================================================================
#  ASTRAL VOID - Post-Apply Reload Hook
# ==============================================================================

THEME_DIR="$HOME/.config/hyde/themes/Astral-Void"

# 1. Asegurar paleta espacial en Kitty evitando el sobreescrito de Wallbash
mkdir -p "$HOME/.config/kitty"
cp -f "$THEME_DIR/configs/kitty/kitty.conf" "$HOME/.config/kitty/theme.conf" 2>/dev/null || true

# 2. Recargar Hyprland
hyprctl reload

# 3. Matar absolutamente todas las instancias de Waybar y reiniciar limpio
killall -9 waybar 2>/dev/null || true
sleep 0.3
waybar & disown

# 4. Recargar Mako
makoctl reload 2>/dev/null || true

# 5. Notificación flotante de confirmación
notify-send -a "HyDE Project" -i "$THEME_DIR/assets/icons/arch_galaxy.png" "Astral Void" "Tema espacial aplicado con éxito."
