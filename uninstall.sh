set -euo pipefail

THEME_NAME="Astral-Void"
AUTHOR_HANDLE="cesarsoriano-dev"
HYDE_THEMES_DIR="${HOME}/.config/hyde/themes"
TARGET_DIR="${HYDE_THEMES_DIR}/${THEME_NAME}"
BACKUP_ROOT="${HOME}/.cache/hyde/backups"
CONFIG_DIR="${HOME}/.config"

C_RESET="\033[0m"
C_BOLD="\033[1m"
C_VIOLET="\033[38;2;189;147;249m"
C_CYAN="\033[38;2;139;233;253m"
C_MAGENTA="\033[38;2;255;121;198m"
C_EMERALD="\033[38;2;80;250;123m"
C_AMBER="\033[38;2;255;184;108m"
C_STARLIGHT="\033[38;2;248;248;242m"
C_MUTED="\033[38;2;98;114;164m"

clear || true

printf "\n"
printf "${C_MAGENTA}   ╭───────────────────────────────────────────────────────────────────────────────────╮${C_RESET}\n"
printf "${C_MAGENTA}   │${C_RESET}  🌌 ${C_STARLIGHT}${C_BOLD}ASTRAL VOID — RESTAURADOR Y DESINSTALADOR ATÓMICO${C_RESET}                             ${C_MAGENTA}│${C_RESET}\n"
printf "${C_MAGENTA}   │${C_RESET}    ${C_CYAN}${C_BOLD}Lead Architect:${C_RESET} ${C_VIOLET}@${AUTHOR_HANDLE}${C_RESET}                                                ${C_MAGENTA}│${C_RESET}\n"
printf "${C_MAGENTA}   ╰───────────────────────────────────────────────────────────────────────────────────╯${C_RESET}\n\n"

LATEST_BACKUP=""
if [ -d "${BACKUP_ROOT}" ]; then
    LATEST_BACKUP=$(find "${BACKUP_ROOT}" -maxdepth 1 -type d -name "${THEME_NAME}_*" | sort -r | head -n 1 || true)
fi

if [ -n "${LATEST_BACKUP}" ] && [ -d "${LATEST_BACKUP}" ]; then
    printf "   ${C_CYAN}${C_BOLD}[1/3]${C_RESET} 󰁯  ${C_STARLIGHT}Restaurando respaldo previo desde:${C_RESET} ${C_AMBER}${LATEST_BACKUP}${C_RESET}\n"

    for app in waybar kitty alacritty foot fastfetch rofi dunst hypr wlogout btop cava gtk-3.0 gtk-4.0 Kvantum; do
        if [ -d "${LATEST_BACKUP}/${app}" ]; then
            rm -rf "${CONFIG_DIR:?}/${app}"
            cp -r "${LATEST_BACKUP}/${app}" "${CONFIG_DIR}/${app}"
        fi
    done

    if [ -f "${LATEST_BACKUP}/starship.toml" ]; then
        rm -f "${CONFIG_DIR}/starship.toml"
        cp -f "${LATEST_BACKUP}/starship.toml" "${CONFIG_DIR}/starship.toml"
    fi
else
    printf "   ${C_AMBER}${C_BOLD}[1/3]${C_RESET}   ${C_STARLIGHT}No se encontró respaldo previo. Limpiando archivos del tema...${C_RESET}\n"
fi

printf "   ${C_CYAN}${C_BOLD}[2/3]${C_RESET} 🧹 ${C_STARLIGHT}Limpiando caché e integraciones de shell (.zshrc / .bashrc)...${C_RESET}\n"

for rc_file in "${HOME}/.zshrc" "${HOME}/.bashrc"; do
    if [ -f "${rc_file}" ]; then
        sed -i '/random_logo_fetch\.sh/d' "${rc_file}" 2>/dev/null || true
    fi
done

rm -f "${HOME}/.cache/hyde/astral_void_logo.png" 2>/dev/null || true
rm -f "${HOME}/.cache/hyde/astral_void_wall.idx" 2>/dev/null || true
rm -f "${HOME}/.cache/hyde/astral_void_icon.idx" 2>/dev/null || true
rm -rf "${HOME}/.cache/fastfetch" 2>/dev/null || true

if [ -d "${TARGET_DIR}" ]; then
    rm -rf "${TARGET_DIR}"
fi

printf "   ${C_CYAN}${C_BOLD}[3/3]${C_RESET} 🔄 ${C_STARLIGHT}Recargando servicios gráficos (Hyprland, Waybar, Dunst, Kitty)...${C_RESET}\n\n"

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

if command -v waybar >/dev/null 2>&1; then
    pkill -x waybar >/dev/null 2>&1 || true
    sleep 0.2
    nohup waybar >/dev/null 2>&1 &
fi

printf "${C_EMERALD}   ╭───────────────────────────────────────────────────────────────────────────────────╮${C_RESET}\n"
printf "${C_EMERALD}   │${C_RESET}  ✔  ${C_STARLIGHT}${C_BOLD}Sistema restaurado a su estado original exitosamente.${C_RESET}                         ${C_EMERALD}│${C_RESET}\n"
printf "${C_EMERALD}   ╰───────────────────────────────────────────────────────────────────────────────────╯${C_RESET}\n\n"
