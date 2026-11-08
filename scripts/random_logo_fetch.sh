set -euo pipefail

ICON_DIR="${HOME}/.config/hyde/themes/Astral-Void/assets/icons"
CACHE_DIR="${HOME}/.cache/hyde"
ACTIVE_LOGO="${CACHE_DIR}/astral_void_logo.png"
CONFIG_FILE="${HOME}/.config/fastfetch/config.jsonc"

mkdir -p "${CACHE_DIR}"

if [ -d "${ICON_DIR}" ]; then
    mapfile -d '' -t ICONS < <(find "${ICON_DIR}" -maxdepth 1 -type f \( -iname "*.png" -o -iname "*.webp" -o -iname "*.jpg" \) -print0 | sort -z)
    TOTAL=${#ICONS[@]}

    if [ "${TOTAL}" -gt 0 ]; then
        RANDOM_IDX=$(( RANDOM % TOTAL ))
        SELECTED_ICON="${ICONS[$RANDOM_IDX]}"
        cp -f "${SELECTED_ICON}" "${ACTIVE_LOGO}"
        rm -rf "${HOME}/.cache/fastfetch" 2>/dev/null || true
        fastfetch --logo "${ACTIVE_LOGO}" --logo-type auto --logo-width 28 --config "${CONFIG_FILE}"
        exit 0
    fi
fi

fastfetch --config "${CONFIG_FILE}"
