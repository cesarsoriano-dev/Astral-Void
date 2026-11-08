set -euo pipefail

THEME_DIR="${HOME}/.config/hyde/themes/Astral-Void"
WALL_DIR="${THEME_DIR}/assets/wallpapers"
ICON_DIR="${THEME_DIR}/assets/icons"
CACHE_DIR="${HOME}/.cache/hyde"
STATE_FILE="${CACHE_DIR}/astral_void_wall.idx"
ACTIVE_LOGO="${CACHE_DIR}/astral_void_logo.png"
ACTION="${1:-next}"

mkdir -p "${CACHE_DIR}"

if [ ! -d "${WALL_DIR}" ]; then
    exit 0
fi

TOTAL=$(find "${WALL_DIR}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | awk 'BEGIN{RS="\0"} END{print NR}')

if [ "${TOTAL}" -eq 0 ]; then
    exit 0
fi

CURRENT_IDX=0
if [ -f "${STATE_FILE}" ]; then
    READ_IDX=$(cat "${STATE_FILE}" 2>/dev/null || echo 0)
    if [[ "${READ_IDX}" =~ ^[0-9]+$ ]]; then
        CURRENT_IDX="${READ_IDX}"
    fi
fi

if [ "${CURRENT_IDX}" -ge "${TOTAL}" ]; then
    CURRENT_IDX=0
fi

case "${ACTION}" in
    next)
        NEXT_IDX=$(( (CURRENT_IDX + 1) % TOTAL ))
        ;;
    prev)
        NEXT_IDX=$(( (CURRENT_IDX - 1 + TOTAL) % TOTAL ))
        ;;
    random)
        if [ "${TOTAL}" -gt 1 ]; then
            NEXT_IDX="${CURRENT_IDX}"
            while [ "${NEXT_IDX}" -eq "${CURRENT_IDX}" ]; do
                NEXT_IDX=$(( RANDOM % TOTAL ))
            done
        else
            NEXT_IDX=0
        fi
        ;;
    *)
        NEXT_IDX="${CURRENT_IDX}"
        ;;
esac

printf "%s\n" "${NEXT_IDX}" > "${STATE_FILE}"
TARGET_LINE=$(( NEXT_IDX + 1 ))
SELECTED_WALL=$(find "${WALL_DIR}" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | sort -z | awk -v n="${TARGET_LINE}" 'BEGIN{RS="\0"; ORS=""} NR==n {print; exit}')

if [ -z "${SELECTED_WALL}" ] || [ ! -f "${SELECTED_WALL}" ]; then
    exit 0
fi

WALL_BASENAME="$(basename "${SELECTED_WALL}")"
WALL_STEM="${WALL_BASENAME%.*}"

ln -sf "${SELECTED_WALL}" "${CACHE_DIR}/wall.set"
ln -sf "${SELECTED_WALL}" "${THEME_DIR}/wall.set"

if [ -d "${ICON_DIR}" ]; then
    MATCHED_ICON="${ICON_DIR}/${WALL_STEM}.png"
    if [ -f "${MATCHED_ICON}" ]; then
        SELECTED_ICON="${MATCHED_ICON}"
    else
        ICON_TOTAL=$(find "${ICON_DIR}" -maxdepth 1 -type f -iname "*.png" -print0 | awk 'BEGIN{RS="\0"} END{print NR}')
        if [ "${ICON_TOTAL}" -gt 0 ]; then
            ICON_LINE=$(( (NEXT_IDX % ICON_TOTAL) + 1 ))
            SELECTED_ICON=$(find "${ICON_DIR}" -maxdepth 1 -type f -iname "*.png" -print0 | sort -z | awk -v n="${ICON_LINE}" 'BEGIN{RS="\0"; ORS=""} NR==n {print; exit}')
        else
            SELECTED_ICON=""
        fi
    fi

    if [ -n "${SELECTED_ICON}" ] && [ -f "${SELECTED_ICON}" ]; then
        cp -f "${SELECTED_ICON}" "${ACTIVE_LOGO}"
        mkdir -p "${HOME}/.config/fastfetch/png"
        cp -f "${SELECTED_ICON}" "${HOME}/.config/fastfetch/png/arch-astral.png"
        rm -rf "${HOME}/.cache/fastfetch" 2>/dev/null || true
    fi
fi

if command -v swww >/dev/null 2>&1; then
    if ! pgrep -x "swww-daemon" >/dev/null 2>&1; then
        swww-daemon --format xrgb >/dev/null 2>&1 &
        sleep 0.3
    fi
    swww img "${SELECTED_WALL}" \
        --transition-type grow \
        --transition-pos 0.85,0.92 \
        --transition-fps 60 \
        --transition-duration 1.8 \
        --transition-bezier 0.25,1,0.5,1
elif command -v hyprctl >/dev/null 2>&1 && pgrep -x "hyprpaper" >/dev/null 2>&1; then
    hyprctl hyprpaper preload "${SELECTED_WALL}" >/dev/null 2>&1 || true
    for mon in $(hyprctl monitors -j | awk -F'"' '/"name":/ {print $4}'); do
        hyprctl hyprpaper wallpaper "${mon},${SELECTED_WALL}" >/dev/null 2>&1 || true
    done
fi

if command -v notify-send >/dev/null 2>&1 && [ "${ACTION}" != "current" ]; then
    notify-send -a "Astral Void" -u low -t 2200 "🌌 Atmósfera Estelar" "Activo: ${WALL_STEM}"
fi
