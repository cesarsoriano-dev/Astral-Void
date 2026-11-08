set -euo pipefail

THEME_DIR="${HOME}/.config/hyde/themes/Astral-Void"
CONFIG_DIR="${HOME}/.config"
CACHE_DIR="${HOME}/.cache/hyde"
ICON_DIR="${THEME_DIR}/assets/icons"
WALL_DIR="${THEME_DIR}/assets/wallpapers"
MAIN_PREVIEW="${THEME_DIR}/assets/astral_void_main.jpg"
ACTIVE_LOGO="${CACHE_DIR}/astral_void_logo.png"

mkdir -p "${CACHE_DIR}"

safe_deploy() {
    local src="$1"
    local dst="$2"

    if [ ! -f "${src}" ]; then
        return 0
    fi

    mkdir -p "$(dirname "${dst}")"

    if [ -L "${dst}" ] || [ "${src}" -ef "${dst}" ]; then
        rm -f "${dst}"
    fi

    cp -f "${src}" "${dst}"
}

hydrate_hex() {
    local target_file="$1"
    if [ -f "${target_file}" ]; then
        awk '{gsub("0x", sprintf("%c", 35)); print}' "${target_file}" > "${target_file}.tmp"
        mv -f "${target_file}.tmp" "${target_file}"
    fi
}

if [ -d "${WALL_DIR}" ] && [ ! -e "${THEME_DIR}/wallpapers" ]; then
    ln -sf "${WALL_DIR}" "${THEME_DIR}/wallpapers"
fi

if [ -f "${MAIN_PREVIEW}" ]; then
    ln -sf "${MAIN_PREVIEW}" "${THEME_DIR}/wall.set"
    if [ ! -e "${CACHE_DIR}/wall.set" ]; then
        ln -sf "${MAIN_PREVIEW}" "${CACHE_DIR}/wall.set"
    fi
    mkdir -p "${CACHE_DIR}/thumbs"
    cp -f "${MAIN_PREVIEW}" "${CACHE_DIR}/wall.quad" 2>/dev/null || true
    cp -f "${MAIN_PREVIEW}" "${CACHE_DIR}/wall.sqre" 2>/dev/null || true
    cp -f "${MAIN_PREVIEW}" "${CACHE_DIR}/wall.thmb" 2>/dev/null || true
fi

safe_deploy "${THEME_DIR}/configs/waybar/config.jsonc" "${CONFIG_DIR}/waybar/config.jsonc"
safe_deploy "${THEME_DIR}/configs/waybar/style.css" "${CONFIG_DIR}/waybar/style.css"
safe_deploy "${THEME_DIR}/configs/kitty/kitty.conf" "${CONFIG_DIR}/kitty/kitty.conf"
safe_deploy "${THEME_DIR}/configs/alacritty/alacritty.toml" "${CONFIG_DIR}/alacritty/alacritty.toml"
safe_deploy "${THEME_DIR}/configs/foot/foot.ini" "${CONFIG_DIR}/foot/foot.ini"
safe_deploy "${THEME_DIR}/configs/fastfetch/config.jsonc" "${CONFIG_DIR}/fastfetch/config.jsonc"
safe_deploy "${THEME_DIR}/configs/rofi/config.rasi" "${CONFIG_DIR}/rofi/config.rasi"
safe_deploy "${THEME_DIR}/configs/dunst/dunstrc" "${CONFIG_DIR}/dunst/dunstrc"
safe_deploy "${THEME_DIR}/configs/hypr/hyprlock.conf" "${CONFIG_DIR}/hypr/hyprlock.conf"
safe_deploy "${THEME_DIR}/configs/wlogout/layout" "${CONFIG_DIR}/wlogout/layout"
safe_deploy "${THEME_DIR}/configs/wlogout/style.css" "${CONFIG_DIR}/wlogout/style.css"
safe_deploy "${THEME_DIR}/configs/starship/starship.toml" "${CONFIG_DIR}/starship.toml"
safe_deploy "${THEME_DIR}/configs/btop/btop.conf" "${CONFIG_DIR}/btop/btop.conf"
safe_deploy "${THEME_DIR}/configs/btop/themes/astral-void.theme" "${CONFIG_DIR}/btop/themes/astral-void.theme"
safe_deploy "${THEME_DIR}/configs/cava/config" "${CONFIG_DIR}/cava/config"
safe_deploy "${THEME_DIR}/configs/gtk-3.0/gtk.css" "${CONFIG_DIR}/gtk-3.0/gtk.css"
safe_deploy "${THEME_DIR}/configs/gtk-3.0/settings.ini" "${CONFIG_DIR}/gtk-3.0/settings.ini"
safe_deploy "${THEME_DIR}/configs/gtk-4.0/gtk.css" "${CONFIG_DIR}/gtk-4.0/gtk.css"
safe_deploy "${THEME_DIR}/configs/gtk-4.0/settings.ini" "${CONFIG_DIR}/gtk-4.0/settings.ini"
safe_deploy "${THEME_DIR}/configs/Kvantum/kvantum.kvconfig" "${CONFIG_DIR}/Kvantum/kvantum.kvconfig"
safe_deploy "${THEME_DIR}/configs/Kvantum/Astral-Void/Astral-Void.kvconfig" "${CONFIG_DIR}/Kvantum/Astral-Void/Astral-Void.kvconfig"
safe_deploy "${THEME_DIR}/configs/qt6ct/qt6ct.conf" "${CONFIG_DIR}/qt6ct/qt6ct.conf"
safe_deploy "${THEME_DIR}/configs/qt6ct/colors/Astral-Void.conf" "${CONFIG_DIR}/qt6ct/colors/Astral-Void.conf"
safe_deploy "${THEME_DIR}/configs/satty/config.toml" "${CONFIG_DIR}/satty/config.toml"
safe_deploy "${THEME_DIR}/configs/qView/qView.conf" "${CONFIG_DIR}/qView/qView.conf"
safe_deploy "${THEME_DIR}/configs/okular/okularpartrc" "${CONFIG_DIR}/okularpartrc"

if [ -f "${CONFIG_DIR}/qt6ct/qt6ct.conf" ]; then
    sed -i "s|/home/\$USER|${HOME}|g" "${CONFIG_DIR}/qt6ct/qt6ct.conf" 2>/dev/null || true
fi

hydrate_hex "${CONFIG_DIR}/kitty/kitty.conf"
hydrate_hex "${CONFIG_DIR}/cava/config"
hydrate_hex "${CONFIG_DIR}/qt6ct/colors/Astral-Void.conf"

if [ -f "${CONFIG_DIR}/kitty/theme.conf" ]; then
    cp -f "${CONFIG_DIR}/kitty/kitty.conf" "${CONFIG_DIR}/kitty/theme.conf" 2>/dev/null || true
fi

if [ -d "${HOME}/.mozilla/firefox" ] && [ -f "${THEME_DIR}/configs/firefox/userChrome.css" ]; then
    for profile_dir in "${HOME}/.mozilla/firefox/"*.default*; do
        if [ -d "${profile_dir}" ]; then
            mkdir -p "${profile_dir}/chrome"
            cp -f "${THEME_DIR}/configs/firefox/userChrome.css" "${profile_dir}/chrome/userChrome.css"
            if ! grep -q "toolkit.legacyUserProfileCustomizations.stylesheets" "${profile_dir}/user.js" 2>/dev/null; then
                printf 'user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);\n' >> "${profile_dir}/user.js"
            fi
        fi
    done
fi

if [ ! -f "${ACTIVE_LOGO}" ]; then
    if [ -f "${ICON_DIR}/astral_void_main.png" ]; then
        cp -f "${ICON_DIR}/astral_void_main.png" "${ACTIVE_LOGO}"
    elif [ -f "${ICON_DIR}/arch-astral.png" ]; then
        cp -f "${ICON_DIR}/arch-astral.png" "${ACTIVE_LOGO}"
    elif [ -d "${ICON_DIR}" ]; then
        FIRST_PNG=$(find "${ICON_DIR}" -maxdepth 1 -type f -iname "*.png" | head -n 1 || true)
        if [ -n "${FIRST_PNG}" ]; then
            cp -f "${FIRST_PNG}" "${ACTIVE_LOGO}"
        fi
    fi
fi

rm -rf "${HOME}/.cache/fastfetch" 2>/dev/null || true

for rc_file in "${HOME}/.zshrc" "${HOME}/.bashrc"; do
    if [ -f "${rc_file}" ]; then
        sed -i '/random_logo_fetch\.sh/d' "${rc_file}" 2>/dev/null || true
        printf "\nalias fastfetch='bash \"\$HOME/.config/hyde/themes/Astral-Void/scripts/random_logo_fetch.sh\"'\n" >> "${rc_file}"
        printf "bash \"\$HOME/.config/hyde/themes/Astral-Void/scripts/random_logo_fetch.sh\"\n" >> "${rc_file}"
    fi
done

if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark' 2>/dev/null || true
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark' 2>/dev/null || true
fi

if command -v xfconf-query >/dev/null 2>&1; then
    xfconf-query -c xsettings -p /Net/ThemeName -s "Adwaita-dark" 2>/dev/null || true
    xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark" 2>/dev/null || true
fi

if command -v pkill >/dev/null 2>&1; then
    pkill -USR1 -x kitty >/dev/null 2>&1 || true
    pkill -USR1 -x cava >/dev/null 2>&1 || true
fi

if command -v dunst >/dev/null 2>&1; then
    pkill -x dunst >/dev/null 2>&1 || true
    nohup dunst >/dev/null 2>&1 &
fi

if command -v hyprctl >/dev/null 2>&1; then
    hyprctl reload >/dev/null 2>&1 || true
fi

killall -9 waybar 2>/dev/null || pkill -9 -x waybar 2>/dev/null || true
sleep 0.3

if command -v waybar >/dev/null 2>&1; then
    nohup waybar -c "${CONFIG_DIR}/waybar/config.jsonc" -s "${CONFIG_DIR}/waybar/style.css" >/dev/null 2>&1 &
fi

if [ -x "${THEME_DIR}/scripts/cycle_wallpaper.sh" ]; then
    bash "${THEME_DIR}/scripts/cycle_wallpaper.sh" current >/dev/null 2>&1 || true
fi
