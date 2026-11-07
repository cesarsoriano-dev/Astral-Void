#!/usr/bin/env bash
# ==============================================================================
#  ASTRAL VOID - Automated Theme Installer for Hyprland / HyDE Project
#  Author: Cesar Soriano
#  License: MIT
# ==============================================================================

set -euo pipefail

# --- ANSI Color Palette ---
CLR_RESET="\033[0m"
CLR_BOLD="\033[1m"
CLR_VOID="\033[38;2;10;8;22m"
CLR_PINK="\033[38;2;255;121;198m"
CLR_CYAN="\033[38;2;139;233;253m"
CLR_AMBER="\033[38;2;255;184;108m"
CLR_VIOLET="\033[38;2;189;147;249m"
CLR_GREEN="\033[38;2;80;250;123m"
CLR_RED="\033[38;2;255;85;85m"
CLR_WHITE="\033[38;2;248;248;242m"

# --- Logging Helpers ---
log_header() {
    echo -e "\n${CLR_VIOLET}${CLR_BOLD}:: $1${CLR_RESET}"
}

log_info() {
    echo -e "  ${CLR_CYAN}➜${CLR_RESET} $1"
}

log_success() {
    echo -e "  ${CLR_GREEN}✔${CLR_RESET} $1"
}

log_warn() {
    echo -e "  ${CLR_AMBER}▲ [ALERTA]${CLR_RESET} $1"
}

log_error() {
    echo -e "  ${CLR_RED}✖ [ERROR]${CLR_RESET} $1" >&2
}

# --- Root Check ---
if [[ $EUID -eq 0 ]]; then
    log_error "No ejecutes este instalador como root (sudo)."
    log_info "El tema debe residir en el espacio de usuario (~/.config/hyde/themes/)."
    exit 1
fi

# --- Banner ---
clear
echo -e "${CLR_PINK}"
cat << "EOF"
    ___         __               __   _   __      _     __
   /   |  _____/ /__________ _  / /  | | / /___  (_)___/ /
  / /| | / ___/ __/ ___/ __ `/ / /   | |/ / __ \/ / __  /
 / ___ |(__  ) /_/ /  / /_/ / / /    | |/ / /_/ / / /_/ /
/_/  |_/____/\__/_/   \__,_/ /_/     |___/\____/_/\__,_/
EOF
echo -e "${CLR_CYAN}    — Deep Space Glassmorphism for Hyprland & HyDE —${CLR_RESET}\n"

# --- Script Location Resolution ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEME_NAME="Astral-Void"
DEST_ROOT="$HOME/.config/hyde/themes"
DEST_THEME="$DEST_ROOT/$THEME_NAME"

# --- 1. Dependency Verification ---
log_header "Verificando dependencias del sistema"

DEPENDENCIES=(
    "hyprctl:hyprland"
    "waybar:waybar"
    "kitty:kitty"
    "rofi:rofi-wayland"
    "swww:swww"
    "mako:mako"
    "fastfetch:fastfetch"
)

OPTIONAL_DEPS=(
    "cava:cava"
    "wlogout:wlogout"
    "matugen:matugen"
)

MISSING_CRITICAL=()

for dep_pair in "${DEPENDENCIES[@]}"; do
    binary="${dep_pair%%:*}"
    package="${dep_pair##*:}"

    if command -v "$binary" &>/dev/null; then
        log_success "Binario encontrado: ${CLR_WHITE}$binary${CLR_RESET}"
    else
        log_error "Falta binario crítico: ${CLR_PINK}$binary${CLR_RESET} (paquete sugerido: ${CLR_AMBER}$package${CLR_RESET})"
        MISSING_CRITICAL+=("$package")
    fi
done

for dep_pair in "${OPTIONAL_DEPS[@]}"; do
    binary="${dep_pair%%:*}"
    package="${dep_pair##*:}"

    if command -v "$binary" &>/dev/null; then
        log_success "Componente complementario: ${CLR_WHITE}$binary${CLR_RESET}"
    else
        log_warn "Opcional no detectado: ${CLR_AMBER}$binary${CLR_RESET} (se puede instalar después con pacman/paru: $package)"
    fi
done

# Font check
if command -v fc-list &>/dev/null; then
    if fc-list : family | grep -iq "JetBrainsMono Nerd Font"; then
        log_success "Fuente detectada: ${CLR_WHITE}JetBrainsMono Nerd Font${CLR_RESET}"
    else
        log_warn "Fuente ${CLR_AMBER}JetBrainsMono Nerd Font${CLR_RESET} no encontrada en fontconfig. Se recomienda instalar ttf-jetbrains-mono-nerd."
    fi
fi

if [[ ${#MISSING_CRITICAL[@]} -gt 0 ]]; then
    echo ""
    log_error "Faltan paquetes esenciales para garantizar el correcto funcionamiento."
    echo -e "    Puedes instalarlos con:\n    ${CLR_CYAN}sudo pacman -S --needed ${MISSING_CRITICAL[*]}${CLR_RESET}\n"
    read -rp "    ¿Deseas continuar con la instalación de los archivos de todos modos? [s/N]: " continue_anyway
    if [[ ! "$continue_anyway" =~ ^[sS]$ ]]; then
        echo -e "\n${CLR_AMBER}Instalación cancelada por el usuario.${CLR_RESET}"
        exit 1
    fi
fi

# --- 2. Theme Integrity Check ---
log_header "Comprobando integridad del paquete"

REQUIRED_ASSETS=(
    "hypr.theme"
    "theme.dmenu"
    "waybar.theme"
    "wallpaper.json"
    "assets/icons/arch_galaxy.png"
    "scripts/post_apply.sh"
    "scripts/generate_colors.sh"
)

for file in "${REQUIRED_ASSETS[@]}"; do
    if [[ ! -f "$SCRIPT_DIR/$file" ]]; then
        log_error "Archivo del tema no encontrado en el origen: $file"
        exit 1
    fi
done
log_success "Estructura interna validada correctamente."

# --- 3. Clean Deployment & Backup Handling ---
log_header "Desplegando en ~/.config/hyde/themes"

mkdir -p "$DEST_ROOT"

if [[ -d "$DEST_THEME" ]]; then
    BACKUP_DIR="${DEST_THEME}.backup_$(date +%Y%m%d_%H%M%S)"
    log_warn "Ya existe una instalación previa en $DEST_THEME."
    log_info "Creando respaldo de seguridad en: ${CLR_WHITE}$BACKUP_DIR${CLR_RESET}"
    mv "$DEST_THEME" "$BACKUP_DIR"
fi

mkdir -p "$DEST_THEME"

# Synchronize theme assets excluding git metadata, build files, and docs
log_info "Copiando archivos del tema..."
rsync -av --quiet \
    --exclude='.git/' \
    --exclude='.github/' \
    --exclude='.gitignore' \
    --exclude='README.md' \
    --exclude='README.es.md' \
    --exclude='install.sh' \
    --exclude='*.backup_*' \
    "$SCRIPT_DIR/" "$DEST_THEME/"

log_success "Archivos transferidos limpiamente."

# --- 4. Permissions Configuration ---
log_header "Configurando permisos de ejecución"

chmod +x "$DEST_THEME/scripts/"*.sh
log_success "Permisos de ejecución concedidos a todos los scripts auxiliares."

# --- 5. Application Prompt ---
log_header "Instalación finalizada"

echo -e "  El tema ${CLR_PINK}${CLR_BOLD}$THEME_NAME${CLR_RESET} se instaló satisfactoriamente en:\n  ${CLR_CYAN}$DEST_THEME${CLR_RESET}\n"

read -rp "  ¿Deseas aplicar el tema inmediatamente en tu sesión activa? [S/n]: " apply_now
apply_now="${apply_now:-s}"

if [[ "$apply_now" =~ ^[sS]$ ]]; then
    log_info "Ejecutando post_apply.sh..."
    bash "$DEST_THEME/scripts/post_apply.sh"
    log_success "Entorno actualizado con éxito."
else
    echo ""
    log_info "Para activarlo manualmente más tarde:"
    echo -e "    1. Presiona ${CLR_CYAN}Super + Shift + T${CLR_RESET} y selecciona ${CLR_PINK}$THEME_NAME${CLR_RESET}."
    echo -e "    2. O ejecuta en terminal: ${CLR_CYAN}$DEST_THEME/scripts/post_apply.sh${CLR_RESET}\n"
fi
