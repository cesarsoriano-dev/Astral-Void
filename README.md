Astral Void — Flagship Cosmic Glassmorphism Theme for HyDE & Hyprland
=====================================================================

![Arch Linux](https://img.shields.io/badge/Arch_Linux_/_CachyOS-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-58E1FF?style=for-the-badge&logo=hyprland&logoColor=0a0816)
![HyDE Project](https://img.shields.io/badge/HyDE_Ecosystem-bd93f9?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-50fa7b?style=for-the-badge)

**Languages:** [English](README.md) | [Español](README.es.md)

**Astral Void** is a complete, production-grade *Cosmic Glassmorphism* desktop environment theme engineered for **Hyprland** and the **HyDE Project** ecosystem. Designed around an abyssal deep-space base (`0a0816`), spectral titanium borders, and nebula accents, it guarantees maximum typography contrast even over hyper-bright supernova wallpapers.

Visual Showcase
---------------

Place your desktop screenshots inside `assets/previews/` (`overview.png`, `lockscreen.png`, `terminals.png`) to showcase your setup:

![Astral Void Overview](assets/previews/overview.png)

Complete 15-Module Ecosystem
----------------------------

Unlike basic color schemes, **Astral Void** styles every single layer of your Linux workflow out of the box:

1. **Waybar (Segmented Floating Pill Architecture):** Modular GTK3 container groups (`group/capsule-*`) with 1px Titanium Spectral borders, internal dividers, and angular gradient active workspaces.
2. **Hyprland Compositor (`hypr.theme`):** Calibrated 3-pass blur (`size = 8`, `passes = 3`), animated spectral borders, and window opacity rules.
3. **Multi-Terminal Suite (`Kitty`, `Alacritty`, `Foot`):** Synchronized `0.78` smoked alpha layers and TrueColor palettes immune to Wallbash washout.
4. **Dynamic 9-Icon Fastfetch Engine:** Rotates automatically across 9 custom cosmic emblems in `assets/icons/` every time you open a terminal or switch wallpapers.
5. **Rofi App Launcher (`config.rasi`):** Floating smoked-glass launcher with pill search bar and *Pulsar Violet* selection highlights.
6. **Dunst Notification Center (`dunstrc`):** Urgency-aware cosmic bubbles with *Horizon Cyan* volume/brightness progress bars.
7. **Sci-Fi Lockscreen (`hyprlock.conf`):** Triple-shield contrast architecture, live battery/AC telemetry dock, and dynamic central avatar ring.
8. **Power Menu (`wlogout`):** Resolution-independent Nerd Font vector cards with semantic hover glow.
9. **Starship Shell Prompt (`starship.toml`):** Powerline micro-capsules matching the Waybar aesthetic with Git and toolchain telemetry.
10. **Btop++ Hardware Monitor (`astral-void.theme`):** Thermal and CPU braille graphs transitioning from *Horizon Cyan* to *Supernova Red*.
11. **Cava Audio Visualizer (`cava/config`):** 60 FPS Monstercat-smoothed 6-stage vertical nebula gradient.
12. **GTK3, GTK4 & Qt/Kvantum Integration:** Translucent sidebars and unified dark-mode accents for **Dolphin**, **Thunar**, **Nautilus**, **Pavucontrol**, and **Blueman**.

Official Color Palette
----------------------

| Role | Name | Hex / RGB / RGBA |
| :--- | :--- | :--- |
| Abyssal Base | Deep Space Background | `0a0816` / `rgb(10, 8, 22)` |
| Cosmic Glass | Capsule & Terminal Surface | `rgba(10, 8, 22, 0.78)` |
| Inner Module | Pill Internal Surface | `120e26` / `rgba(18, 14, 38, 0.65)` |
| Starlight | Primary Foreground Text | `f8f8f2` / `rgb(248, 248, 242)` |
| Dim Nebula | Inactive / Muted Elements | `6272a4` / `rgb(98, 114, 164)` |
| Pulsar Violet | Primary Accent / Active Window | `bd93f9` / `rgb(189, 147, 249)` |
| Titanium Border | Spectral Capsule Outline | `rgba(189, 147, 249, 0.28)` |
| Horizon Cyan | Interactive Hover / Cursor | `8be9fd` / `rgb(139, 233, 253)` |
| Supernova Magenta | App Launcher / Power Accent | `ff79c6` / `rgb(255, 121, 198)` |
| Supernova Red | Critical Alert / Muted Audio | `ff5555` / `rgb(255, 85, 85)` |
| Stellar Amber | Warning State / Backlight | `ffb86c` / `rgb(255, 184, 108)` |
| Cosmic Emerald | Optimal Network / Charging | `50fa7b` / `rgb(80, 250, 123)` |

Repository Architecture
-----------------------

```text
Astral-Void/
├── assets/
│   ├── icons/
│   │   ├── arch-astral.png
│   │   ├── astral_void_main.png
│   │   ├── Collision of Galaxies.png
│   │   ├── Crystalline Storm.png
│   │   ├── Magical Planet and Nature.png
│   │   ├── Mystical Crystal Cave.png
│   │   ├── Mystical Planet of Magic.png
│   │   ├── Space Explosion Nebula.png
│   │   └── Space storm.png
│   └── previews/
├── configs/
│   ├── alacritty/alacritty.toml
│   ├── btop/
│   │   ├── btop.conf
│   │   └── themes/astral-void.theme
│   ├── cava/config
│   ├── dunst/dunstrc
│   ├── fastfetch/config.jsonc
│   ├── foot/foot.ini
│   ├── gtk-3.0/gtk.css
│   ├── gtk-4.0/gtk.css
│   ├── hypr/hyprlock.conf
│   ├── kitty/kitty.conf
│   ├── Kvantum/
│   │   ├── kvantum.kvconfig
│   │   └── Astral-Void/Astral-Void.kvconfig
│   ├── rofi/config.rasi
│   ├── starship/starship.toml
│   ├── waybar/
│   │   ├── config.jsonc
│   │   └── style.css
│   └── wlogout/
│       ├── layout
│       └── style.css
├── scripts/
│   ├── cycle_wallpaper.sh
│   ├── post_apply.sh
│   └── random_logo_fetch.sh
├── wallpapers/
├── .gitignore
├── hypr.theme
├── install.sh
├── LICENSE
├── README.es.md
├── README.md
├── theme.dmenu
├── uninstall.sh
├── wallpaper.json
└── waybar.theme
