#!/usr/bin/env bash
set -euo pipefail

readonly THEME_NAME="Astral-Void"
readonly HYDE_THEME_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hyde/themes/${THEME_NAME}"
readonly WAYBAR_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/waybar"
readonly KITTY_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kitty"

enforce_kitty_glass() {
    mkdir -p "$KITTY_DIR"

    if [[ -f "${HYDE_THEME_DIR}/configs/kitty/kitty.conf" ]]; then
        ln -snf "${HYDE_THEME_DIR}/configs/kitty/kitty.conf" "${KITTY_DIR}/kitty.conf"
        cp -f "${HYDE_THEME_DIR}/configs/kitty/kitty.conf" "${KITTY_DIR}/theme.conf"
    fi

    if pgrep -x "kitty" >/dev/null 2>&1; then
        pkill -USR1 -x kitty 2>/dev/null || true
    fi
}

reload_hyprland() {
    if command -v hyprctl >/dev/null 2>&1 && [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
        hyprctl reload >/dev/null 2>&1 || true
    fi
}

restart_waybar_atomic() {
    mkdir -p "$WAYBAR_DIR"

    if [[ -f "${HYDE_THEME_DIR}/configs/waybar/config.jsonc" ]]; then
        ln -snf "${HYDE_THEME_DIR}/configs/waybar/config.jsonc" "${WAYBAR_DIR}/config.jsonc"
    fi

    if [[ -f "${HYDE_THEME_DIR}/configs/waybar/style.css" ]]; then
        ln -snf "${HYDE_THEME_DIR}/configs/waybar/style.css" "${WAYBAR_DIR}/style.css"
    fi

    if pgrep -x "waybar" >/dev/null 2>&1; then
        killall -9 waybar 2>/dev/null || true
        local retries=0
        while pgrep -x "waybar" >/dev/null 2>&1 && [[ "$retries" -lt 20 ]]; do
            sleep 0.1
            retries=$((retries + 1))
        done
    fi

    nohup waybar \
        -c "${WAYBAR_DIR}/config.jsonc" \
        -s "${WAYBAR_DIR}/style.css" \
        >/dev/null 2>&1 &
    disown
}

ensure_tray_daemons() {
    if command -v nm-applet >/dev/null 2>&1; then
        if ! pgrep -x "nm-applet" >/dev/null 2>&1; then
            nohup nm-applet --indicator >/dev/null 2>&1 &
            disown
        fi
    fi

    if command -v blueman-applet >/dev/null 2>&1; then
        if ! pgrep -x "blueman-applet" >/dev/null 2>&1; then
            nohup blueman-applet >/dev/null 2>&1 &
            disown
        fi
    fi
}

notify_user() {
    if command -v notify-send >/dev/null 2>&1; then
        local icon="preferences-desktop-theme"
        if [[ -f "${HYDE_THEME_DIR}/assets/icons/arch_galaxy.png" ]]; then
            icon="${HYDE_THEME_DIR}/assets/icons/arch_galaxy.png"
        fi

        notify-send \
            -a "HyDE Theme Engine" \
            -u normal \
            -i "$icon" \
            "🌌 Astral Void Activado" \
            "Cosmic Glassmorphism sincronizado en Hyprland, Waybar y Kitty."
    fi
}

main() {
    enforce_kitty_glass
    reload_hyprland
    restart_waybar_atomic
    ensure_tray_daemons
    notify_user
}

main "$@"
