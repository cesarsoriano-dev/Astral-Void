#!/usr/bin/env bash
# ==============================================================================
#  ASTRAL VOID - Automated Installer for Hyprland & HyDE Project
# ==============================================================================

set -euo pipefail

CLR_RESET="\033[0m"
CLR_BOLD="\033[1m"
CLR_CYAN="\033[38;2;139;233;253m"
CLR_PINK="\033[38;2;255;121;198m"
CLR_GREEN="\033[38;2;80;250;123m"
CLR_AMBER="\033[38;2;255;184;108m"
CLR_RED="\033[38;2;255;85;85m"
CLR_WHITE="\033[38;2;248;248;242m"

if [[ $EUID -eq 0 ]]; then
    echo -e "${CLR_RED}✖ Error: No ejecutes este script con sudo.${CLR_RESET}" >&2
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="Astral-Void"
DEST_ROOT="$HOME/.config/hyde/themes"
DEST_THEME="$DEST_ROOT/$THEME_NAME"
BACKUP_DIR="$HOME/.cache/hyde/theme_backups"

clear
echo -e "${CLR_PINK}${CLR_BOLD}"
cat << "EOF"
    ___         __               __   _   __      _     __
   /   |  _____/ /__________ _  / /  | | / /___  (_)___/ /
  / /| | / ___/ __/ ___/ __ `/ / /   | |/ / __ \/ / __  /
 / ___ |(__  ) /_/ /  / /_/ / / /    | |/ / /_/ / / /_/ /
/_/  |_/____/\__/_/   \__,_/ /_/     |___/\____/_/\__,_/
EOF
echo -e "${CLR_CYAN}  :: Instalador Oficial - HyDE Project ::${CLR_RESET}\n"

# 1. Verificación de dependencias esenciales
echo -e "${CLR_CYAN}➜ Comprobando dependencias...${CLR_RESET}"
DEPS=("hyprctl:hyprland" "waybar:waybar" "kitty:kitty" "rofi:rofi-wayland" "swww:swww" "pavucontrol:pavucontrol")
MISSING=()

for item in "${DEPS[@]}"; do
    bin="${item%%:*}"
    pkg="${item##*:}"
    if command -v "$bin" &>/dev/null; then
        echo -e "  ${CLR_GREEN}✔${CLR_RESET} $bin encontrado."
    else
        echo -e "  ${CLR_AMBER}▲${CLR_RESET} Falta: $bin (paquete: $pkg)"
        MISSING+=("$pkg")
    fi
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
    echo -e "\n${CLR_AMBER}Se sugiere instalar paquetes faltantes con:${CLR_RESET}"
    echo -e "sudo pacman -S --needed ${MISSING[*]}\n"
fi

# 2. Respaldo limpio fuera de la lista de temas
mkdir -p "$DEST_ROOT"
mkdir -p "$BACKUP_DIR"

if [[ -d "$DEST_THEME" ]]; then
    TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
    echo -e "${CLR_AMBER}➜ Moviendo versión anterior a respaldo:${CLR_RESET} $BACKUP_DIR/Astral-Void_$TIMESTAMP"
    mv "$DEST_THEME" "$BACKUP_DIR/Astral-Void_$TIMESTAMP"
fi

# 3. Copia limpia de archivos
echo -e "${CLR_CYAN}➜ Desplegando tema en ~/.config/hyde/themes/Astral-Void...${CLR_RESET}"
mkdir -p "$DEST_THEME"

rsync -av --quiet \
    --exclude='.git/' \
    --exclude='.gitignore' \
    --exclude='README.md' \
    --exclude='README.es.md' \
    --exclude='install.sh' \
    "$SCRIPT_DIR/" "$DEST_THEME/"

# 4. Asignación estricta de permisos de ejecución
chmod +x "$DEST_THEME/scripts/"*.sh

# 5. Enlaces simbólicos de Waybar para evitar desincronización
mkdir -p "$HOME/.config/waybar"
ln -sf "$DEST_THEME/configs/waybar/config.jsonc" "$HOME/.config/waybar/config.jsonc"
ln -sf "$DEST_THEME/configs/waybar/style.css" "$HOME/.config/waybar/style.css"

echo -e "${CLR_GREEN}✔ Instalación finalizada con éxito.${CLR_RESET}\n"

read -rp "  ¿Deseas aplicar Astral Void ahora mismo? [S/n]: " RUN_NOW
RUN_NOW="${RUN_NOW:-s}"

if [[ "$RUN_NOW" =~ ^[sS]$ ]]; then
    bash "$DEST_THEME/scripts/post_apply.sh"
fi
