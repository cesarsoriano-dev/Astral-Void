#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
    printf "\033[1;31m[ERROR]\033[0m No ejecutes este script como superusuario (sin sudo).\n" >&2
    exit 1
fi

readonly THEME_NAME="Astral-Void"
readonly REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly HYDE_THEMES_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hyde/themes"
readonly TARGET_THEME_DIR="${HYDE_THEMES_DIR}/${THEME_NAME}"
readonly BACKUP_ROOT="${XDG_CACHE_HOME:-$HOME/.cache}/hyde/theme_backups"
readonly TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
readonly CURRENT_BACKUP_DIR="${BACKUP_ROOT}/Astral_Void_${TIMESTAMP}"

readonly WAYBAR_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/waybar"
readonly KITTY_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kitty"

log_info() {
    printf "\033[1;36m[INFO]\033[0m %s\n" "$1"
}

log_warn() {
    printf "\033[1;33m[WARN]\033[0m %s\n" "$1"
}

log_error() {
    printf "\033[1;31m[ERROR]\033[0m %s\n" "$1" >&2
}

check_dependencies() {
    log_info "Verificando dependencias del ecosistema Hyprland / HyDE..."
    local critical_deps=("hyprctl" "waybar" "kitty" "rofi" "jq")
    local optional_deps=("pavucontrol" "blueman-manager" "nm-connection-editor" "btop" "wlogout" "brightnessctl" "wpctl" "notify-send" "swww")
    local missing_critical=0

    for cmd in "${critical_deps[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            log_error "Dependencia crítica no encontrada: $cmd"
            missing_critical=1
        fi
    done

    if [[ "$missing_critical" -eq 1 ]]; then
        log_error "Instala las dependencias críticas antes de continuar."
        exit 1
    fi

    for cmd in "${optional_deps[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            log_warn "Utilidad recomendada no instalada: $cmd"
        fi
    done
}

verify_repo_structure() {
    log_info "Auditando integridad de archivos fuente del tema..."
    local required_files=(
        "${REPO_DIR}/hypr.theme"
        "${REPO_DIR}/scripts/post_apply.sh"
        "${REPO_DIR}/configs/kitty/kitty.conf"
        "${REPO_DIR}/configs/waybar/config.jsonc"
        "${REPO_DIR}/configs/waybar/style.css"
    )

    for file in "${required_files[@]}"; do
        if [[ ! -f "$file" ]]; then
            log_error "Archivo fuente faltante: $file"
            exit 1
        fi
    done
}

backup_existing_configs() {
    log_info "Desviando respaldos hacia ${CURRENT_BACKUP_DIR} (fuera del selector de HyDE)..."
    mkdir -p "$CURRENT_BACKUP_DIR"

    if [[ -d "$TARGET_THEME_DIR" ]]; then
        cp -a "$TARGET_THEME_DIR" "${CURRENT_BACKUP_DIR}/hyde_theme_dir"
        rm -rf "$TARGET_THEME_DIR"
    fi

    # Patrón ampliado para capturar respaldos con guiones, espacios o puntos
    shopt -s nullglob
    local stray_backups=("${HYDE_THEMES_DIR}/Astral-Void"* "${HYDE_THEMES_DIR}/Astral Void"* "${HYDE_THEMES_DIR}/Astral_Void"*)
    shopt -u nullglob

    for stray in "${stray_backups[@]}"; do
        if [[ -e "$stray" && "$stray" != "$TARGET_THEME_DIR" ]]; then
            log_warn "Limpiando respaldo huérfano detectado en carpeta de temas: $(basename "$stray")"
            mv "$stray" "${CURRENT_BACKUP_DIR}/"
        fi
    done

    if [[ -d "$WAYBAR_CONFIG_DIR" ]]; then
        mkdir -p "${CURRENT_BACKUP_DIR}/waybar"
        for item in config.jsonc style.css; do
            if [[ -e "${WAYBAR_CONFIG_DIR}/${item}" || -L "${WAYBAR_CONFIG_DIR}/${item}" ]]; then
                cp -aL "${WAYBAR_CONFIG_DIR}/${item}" "${CURRENT_BACKUP_DIR}/waybar/" 2>/dev/null || true
            fi
        done
    fi

    if [[ -d "$KITTY_CONFIG_DIR" ]]; then
        mkdir -p "${CURRENT_BACKUP_DIR}/kitty"
        if [[ -e "${KITTY_CONFIG_DIR}/kitty.conf" || -L "${KITTY_CONFIG_DIR}/kitty.conf" ]]; then
            cp -aL "${KITTY_CONFIG_DIR}/kitty.conf" "${CURRENT_BACKUP_DIR}/kitty/" 2>/dev/null || true
        fi
    fi
}

install_theme_files() {
    log_info "Instalando estructura del tema en ${TARGET_THEME_DIR}..."
    mkdir -p "${TARGET_THEME_DIR}/scripts"
    mkdir -p "${TARGET_THEME_DIR}/configs/kitty"
    mkdir -p "${TARGET_THEME_DIR}/configs/waybar"
    mkdir -p "$WAYBAR_CONFIG_DIR"
    mkdir -p "$KITTY_CONFIG_DIR"

    # Archivos core
    cp -f "${REPO_DIR}/hypr.theme" "${TARGET_THEME_DIR}/hypr.theme"
    cp -f "${REPO_DIR}/scripts/post_apply.sh" "${TARGET_THEME_DIR}/scripts/post_apply.sh"
    cp -f "${REPO_DIR}/configs/kitty/kitty.conf" "${TARGET_THEME_DIR}/configs/kitty/kitty.conf"
    cp -f "${REPO_DIR}/configs/waybar/config.jsonc" "${TARGET_THEME_DIR}/configs/waybar/config.jsonc"
    cp -f "${REPO_DIR}/configs/waybar/style.css" "${TARGET_THEME_DIR}/configs/waybar/style.css"

    # Archivos de metadatos de HyDE (si existen en el repo)
    for meta in wallpaper.json theme.dmenu waybar.theme; do
        if [[ -f "${REPO_DIR}/${meta}" ]]; then
            cp -f "${REPO_DIR}/${meta}" "${TARGET_THEME_DIR}/${meta}"
        fi
    done

    # Copia completa de assets (wallpapers e iconos)
    if [[ -d "${REPO_DIR}/assets" ]]; then
        cp -rf "${REPO_DIR}/assets" "${TARGET_THEME_DIR}/"
    fi

    chmod 755 "${TARGET_THEME_DIR}/scripts/post_apply.sh"
    chmod 755 "${REPO_DIR}/scripts/post_apply.sh"

    log_info "Creando enlaces simbólicos hacia ~/.config/waybar y ~/.config/kitty..."
    ln -snf "${TARGET_THEME_DIR}/configs/waybar/config.jsonc" "${WAYBAR_CONFIG_DIR}/config.jsonc"
    ln -snf "${TARGET_THEME_DIR}/configs/waybar/style.css" "${WAYBAR_CONFIG_DIR}/style.css"
    ln -snf "${TARGET_THEME_DIR}/configs/kitty/kitty.conf" "${KITTY_CONFIG_DIR}/kitty.conf"
    ln -snf "${TARGET_THEME_DIR}/configs/kitty/kitty.conf" "${KITTY_CONFIG_DIR}/theme.conf"
}

main() {
    check_dependencies
    verify_repo_structure
    backup_existing_configs
    install_theme_files

    log_info "Ejecutando hook de post-aplicación..."
    bash "${TARGET_THEME_DIR}/scripts/post_apply.sh"

    log_info "Instalación de '${THEME_NAME}' completada con éxito."
}

main "$@"
