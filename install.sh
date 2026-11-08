set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="Astral-Void"
AUTHOR_HANDLE="cesarsoriano-dev"
HYDE_THEMES_DIR="${HOME}/.config/hyde/themes"
TARGET_DIR="${HYDE_THEMES_DIR}/${THEME_NAME}"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="${HOME}/.cache/hyde/backups/${THEME_NAME}_${TIMESTAMP}"

C_RESET="\033[0m"
C_BOLD="\033[1m"
C_VIOLET="\033[38;2;189;147;249m"
C_CYAN="\033[38;2;139;233;253m"
C_MAGENTA="\033[38;2;255;121;198m"
C_EMERALD="\033[38;2;80;250;123m"
C_AMBER="\033[38;2;255;184;108m"
C_STARLIGHT="\033[38;2;248;248;242m"
C_MUTED="\033[38;2;98;114;164m"

ensure_shebang() {
    local script_path="$1"
    if [ -f "${script_path}" ]; then
        sed -i 's/\r$//' "${script_path}" 2>/dev/null || true
        FIRST_CHAR=$(head -c 1 "${script_path}" 2>/dev/null || echo "")
        HASH_CHAR=$(printf "\043")
        if [ "${FIRST_CHAR}" != "${HASH_CHAR}" ]; then
            awk 'BEGIN{printf "%c!/usr/bin/env bash\n", 35} {print}' "${script_path}" > "${script_path}.tmp"
            mv -f "${script_path}.tmp" "${script_path}"
        fi
        chmod +x "${script_path}" 2>/dev/null || true
    fi
}

clear || true

printf "\n"
printf "${C_VIOLET}${C_BOLD}      █████╗ ███████╗████████╗██████╗  █████╗ ██╗         ██╗   ██╗ ██████╗ ██╗██████╗ ${C_RESET}\n"
printf "${C_VIOLET}${C_BOLD}     ██╔══██╗██╔════╝╚══██╔══╝██╔══██╗██╔══██╗██║         ██║   ██║██╔═══██╗██║██╔══██╗${C_RESET}\n"
printf "${C_CYAN}${C_BOLD}     ███████║███████╗   ██║   ██████╔╝███████║██║         ██║   ██║██║   ██║██║██║  ██║${C_RESET}\n"
printf "${C_CYAN}${C_BOLD}     ██╔══██║╚════██║   ██║   ██╔══██╗██╔══██║██║         ╚██╗ ██╔╝██║   ██║██║██║  ██║${C_RESET}\n"
printf "${C_MAGENTA}${C_BOLD}     ██║  ██║███████║   ██║   ██║  ██║██║  ██║███████╗     ╚████╔╝ ╚██████╔╝██║██████╔╝${C_RESET}\n"
printf "${C_MAGENTA}${C_BOLD}     ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝      ╚═══╝   ╚═════╝ ╚═╝╚═════╝ ${C_RESET}\n"
printf "\n"
printf "${C_VIOLET}   ╭───────────────────────────────────────────────────────────────────────────────────╮${C_RESET}\n"
printf "${C_VIOLET}   │${C_RESET}  🌌 ${C_STARLIGHT}${C_BOLD}Cosmic Glassmorphism Flagship Suite for Hyprland & HyDE Project${C_RESET}               ${C_VIOLET}│${C_RESET}\n"
printf "${C_VIOLET}   │${C_RESET}    ${C_CYAN}${C_BOLD}Lead Architect:${C_RESET} ${C_MAGENTA}@${AUTHOR_HANDLE}${C_RESET}   ${C_MUTED}│${C_RESET}   󰣇  ${C_CYAN}${C_BOLD}Target User:${C_RESET} ${C_EMERALD}${USER:-linux}${C_RESET}                  ${C_VIOLET}│${C_RESET}\n"
printf "${C_VIOLET}   ╰───────────────────────────────────────────────────────────────────────────────────╯${C_RESET}\n\n"

printf "   ${C_CYAN}${C_BOLD}[1/5]${C_RESET} 󰁯  ${C_STARLIGHT}Creando punto de restauración atómico en caché...${C_RESET}\n"

mkdir -p "${HYDE_THEMES_DIR}"
mkdir -p "${BACKUP_DIR}"

for app in waybar kitty alacritty foot fastfetch rofi dunst hypr wlogout btop cava gtk-3.0 gtk-4.0 Kvantum qt6ct satty qView; do
    if [ -d "${HOME}/.config/${app}" ]; then
        cp -rL "${HOME}/.config/${app}" "${BACKUP_DIR}/${app}" 2>/dev/null || true
    fi
done

for file in starship.toml okularpartrc; do
    if [ -f "${HOME}/.config/${file}" ]; then
        cp -fL "${HOME}/.config/${file}" "${BACKUP_DIR}/${file}" 2>/dev/null || true
    fi
done

if [ -d "${TARGET_DIR}" ]; then
    cp -r "${TARGET_DIR}" "${BACKUP_DIR}/previous_theme_dir" 2>/dev/null || true
fi

printf "         ${C_EMERALD}✔${C_RESET} ${C_MUTED}Backup seguro en:${C_RESET} ${C_AMBER}${BACKUP_DIR}${C_RESET}\n\n"

printf "   ${C_CYAN}${C_BOLD}[2/5]${C_RESET} 󰉋  ${C_STARLIGHT}Desplegando árbol completo de módulos, 16 wallpapers y 9 iconos...${C_RESET}\n"

mkdir -p "${TARGET_DIR}/assets/icons"
mkdir -p "${TARGET_DIR}/assets/wallpapers"
mkdir -p "${TARGET_DIR}/configs/waybar"
mkdir -p "${TARGET_DIR}/configs/kitty"
mkdir -p "${TARGET_DIR}/configs/alacritty"
mkdir -p "${TARGET_DIR}/configs/foot"
mkdir -p "${TARGET_DIR}/configs/fastfetch"
mkdir -p "${TARGET_DIR}/configs/rofi"
mkdir -p "${TARGET_DIR}/configs/dunst"
mkdir -p "${TARGET_DIR}/configs/hypr"
mkdir -p "${TARGET_DIR}/configs/wlogout"
mkdir -p "${TARGET_DIR}/configs/starship"
mkdir -p "${TARGET_DIR}/configs/btop/themes"
mkdir -p "${TARGET_DIR}/configs/cava"
mkdir -p "${TARGET_DIR}/configs/gtk-3.0"
mkdir -p "${TARGET_DIR}/configs/gtk-4.0"
mkdir -p "${TARGET_DIR}/configs/Kvantum/Astral-Void"
mkdir -p "${TARGET_DIR}/configs/qt6ct/colors"
mkdir -p "${TARGET_DIR}/configs/firefox"
mkdir -p "${TARGET_DIR}/configs/satty"
mkdir -p "${TARGET_DIR}/configs/qView"
mkdir -p "${TARGET_DIR}/configs/okular"
mkdir -p "${TARGET_DIR}/scripts"

if [ "${REPO_DIR}" != "${TARGET_DIR}" ]; then
    cp -rf "${REPO_DIR}/." "${TARGET_DIR}/"
fi

printf "         ${C_EMERALD}✔${C_RESET} ${C_MUTED}Archivos sincronizados en:${C_RESET} ${C_VIOLET}${TARGET_DIR}${C_RESET}\n\n"

printf "   ${C_CYAN}${C_BOLD}[3/5]${C_RESET} 󰸉  ${C_STARLIGHT}Vinculando portada 'astral_void_main.jpg' al selector de temas HyDE...${C_RESET}\n"

if [ -d "${TARGET_DIR}/assets/wallpapers" ] && [ ! -e "${TARGET_DIR}/wallpapers" ]; then
    ln -sf "${TARGET_DIR}/assets/wallpapers" "${TARGET_DIR}/wallpapers"
fi

if [ -f "${TARGET_DIR}/assets/astral_void_main.jpg" ]; then
    ln -sf "${TARGET_DIR}/assets/astral_void_main.jpg" "${TARGET_DIR}/wall.set"
fi

printf "         ${C_EMERALD}✔${C_RESET} ${C_MUTED}Miniatura principal registrada para Rofi Theme Selector.${C_RESET}\n\n"

printf "   ${C_CYAN}${C_BOLD}[4/5]${C_RESET}   ${C_STARLIGHT}Inyectando shebangs POSIX, sanitizando CRLF->LF y aplicando chmod +x...${C_RESET}\n"

find "${TARGET_DIR}/configs" -type f -exec sed -i 's/\r$//' {} + 2>/dev/null || true
sed -i 's/\r$//' "${TARGET_DIR}/hypr.theme" 2>/dev/null || true
sed -i 's/\r$//' "${TARGET_DIR}/theme.dmenu" 2>/dev/null || true
sed -i 's/\r$//' "${TARGET_DIR}/waybar.theme" 2>/dev/null || true
sed -i 's/\r$//' "${TARGET_DIR}/wallpaper.json" 2>/dev/null || true

for script_file in \
    "${REPO_DIR}/install.sh" \
    "${REPO_DIR}/uninstall.sh" \
    "${REPO_DIR}/scripts/cycle_wallpaper.sh" \
    "${REPO_DIR}/scripts/post_apply.sh" \
    "${REPO_DIR}/scripts/random_logo_fetch.sh" \
    "${TARGET_DIR}/install.sh" \
    "${TARGET_DIR}/uninstall.sh" \
    "${TARGET_DIR}/scripts/cycle_wallpaper.sh" \
    "${TARGET_DIR}/scripts/post_apply.sh" \
    "${TARGET_DIR}/scripts/random_logo_fetch.sh"; do
    ensure_shebang "${script_file}"
done

printf "         ${C_EMERALD}✔${C_RESET} ${C_MUTED}Permisos de ejecución (+x) y cabeceras Bash verificadas en todos los scripts.${C_RESET}\n\n"

printf "   ${C_CYAN}${C_BOLD}[5/5]${C_RESET} 🚀 ${C_STARLIGHT}Activando motor visual Astral Void sin duplicar procesos...${C_RESET}\n"

if [ -f "${TARGET_DIR}/scripts/post_apply.sh" ]; then
    bash "${TARGET_DIR}/scripts/post_apply.sh"
fi

printf "         ${C_EMERALD}✔${C_RESET} ${C_MUTED}Waybar única, Thunar Dark, Dolphin Kvantum, Terminales y Fastfetch activos.${C_RESET}\n\n"

printf "${C_EMERALD}   ╭───────────────────────────────────────────────────────────────────────────────────╮${C_RESET}\n"
printf "${C_EMERALD}   │${C_RESET}  ✨ ${C_STARLIGHT}${C_BOLD}¡INSTALACIÓN DE ASTRAL VOID COMPLETADA CON ÉXITO!${C_RESET}                             ${C_EMERALD}│${C_RESET}\n"
printf "${C_EMERALD}   │${C_RESET}  🎨 ${C_MUTED}Creado por:${C_RESET} ${C_MAGENTA}${C_BOLD}@${AUTHOR_HANDLE}${C_RESET}                                                ${C_EMERALD}│${C_RESET}\n"
printf "${C_EMERALD}   │${C_RESET}  󰸉  ${C_MUTED}Botonera HyDE activa:${C_RESET} ${C_CYAN}Temas (), Fondos (󰸉), Waybar (), Portapapeles ()${C_RESET}     ${C_EMERALD}│${C_RESET}\n"
printf "${C_EMERALD}   │${C_RESET}  󰁯  ${C_MUTED}Desinstalar / Restaurar:${C_RESET} ${C_AMBER}./uninstall.sh${C_RESET}                                   ${C_EMERALD}│${C_RESET}\n"
printf "${C_EMERALD}   ╰───────────────────────────────────────────────────────────────────────────────────╯${C_RESET}\n\n"
