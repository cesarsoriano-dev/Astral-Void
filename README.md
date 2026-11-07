<div align="center">

# 🌌 Astral Void

**A glassmorphic deep-space theme ecosystem for Hyprland and HyDE Project**

[![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-8be9fd?style=flat-square&logo=archlinux&logoColor=white)](https://hyprland.org/)
[![HyDE](https://img.shields.io/badge/HyDE-Project-bd93f9?style=flat-square)](https://github.com/HyDE-Project)
[![License: MIT](https://img.shields.io/badge/License-MIT-ff79c6?style=flat-square)](LICENSE)

*Immerse your desktop into an interstellar event horizon: deep abyssal backgrounds, frosted refraction, and high-energy plasma accents.*

[English](README.md) • [Español](README.es.md)

---

![Astral Void Preview](assets/preview.png)

</div>

## ✨ Overview

**Astral Void** is a unified desktop configuration engineered for Arch Linux and CachyOS utilizing the **HyDE Project** architecture. It pairs deep void backgrounds (`#0a0816`) with high-energy accents inspired by stellar nurseries, crystal caverns, and kilonova plasma storms.

### 🎨 Color Specification

| Color Role | Hex | Alpha (Hex) | Purpose |
| :--- | :---: | :---: | :--- |
| **Abyssal Void** | `#0a0816` | `#0a0816cc` | Main backgrounds & frosted glass blur |
| **Card Surface** | `#16122c` | `#16122cb3` | Inner container frames and cards |
| **Plasma Pink** | `#ff79c6` | `#ff79c6ff` | Active borders, accents, primary indicators |
| **Cosmic Cyan** | `#8be9fd` | `#8be9fdff` | Workspace indicators, cursor focus, sparks |
| **Solar Amber** | `#ffb86c` | `#ffb86cff` | Warnings, telemetry alerts, hardware metrics |
| **Astral Violet** | `#bd93f9` | `#bd93f9ff` | Glass highlights, secondary border stop |
| **Stellar White** | `#f8f8f2` | `#f8f8f2ff` | High-contrast foreground text |

---

## 🚀 Components

- **Hyprland:** Quad-color revolving gradient borders (`col.active_border`), 3-pass frosted glass blur, and custom spring curves.
- **Waybar:** Three isolated floating glass capsules with top-edge specular refracion, custom workspaces morphing, CPU/RAM telemetry, and audio controls.
- **Rofi (theme.dmenu):** Spotlight-style floating launcher with neon borders, blur, and pill-shaped selection fields.
- **Terminal (Kitty + Fastfetch):** 78% opacity glass background, custom Arch galaxy logo integration, and ANSI space palette.
- **System Interface:** Translucent Mako notification toasts, Cava audio spectrum visualizer, and Wlogout glass power controls.

---

## 📂 Repository Layout

```text
Astral-Void/
├── hypr.theme             # Core Hyprland configuration (gaps, borders, blur, rules)
├── theme.dmenu            # Rofi / Dmenu design template
├── waybar.theme           # Waybar root CSS color variables
├── wallpaper.json         # Swww transition metadata and base palette
├── assets/
│   ├── wallpapers/        # 4K & 1080p cosmic space wallpapers
│   ├── icons/             # arch_galaxy.png (Fastfetch & notifications)
│   └── preview.png        # Theme card for HyDE theme selector
├── configs/
│   ├── fastfetch/         # System summary config and ASCII star fallback
│   ├── kitty/             # Terminal colors and opacity
│   ├── mako/              # Notification rules and styling
│   ├── waybar/            # Modular JSONC layout & glassmorphic CSS
│   ├── wlogout/           # Power menu layout & stylesheet
│   └── cava/              # Multi-gradient audio visualizer config
└── scripts/
    ├── generate_colors.sh # Automatic palette extractor (Matugen / Pywal)
    └── post_apply.sh      # Runtime hook executed when theme is activated
