<div align="center">

# 🌌 Astral Void

**Ecosistema visual con estética espacial y glassmorphism para Hyprland y HyDE Project**

[![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-8be9fd?style=flat-square&logo=archlinux&logoColor=white)](https://hyprland.org/)
[![HyDE](https://img.shields.io/badge/HyDE-Project-bd93f9?style=flat-square)](https://github.com/HyDE-Project)
[![Licencia: MIT](https://img.shields.io/badge/Licencia-MIT-ff79c6?style=flat-square)](LICENSE)

*Sumerge tu entorno de escritorio en un horizonte de sucesos cósmico: fondos abisales oscuros, refracción de cristal esmerilado y destellos de plasma de alta energía.*

[English](README.md) • [Español](README.es.md)

---

![Vista previa de Astral Void](assets/preview.png)

</div>

## ✨ Descripción general

**Astral Void** es una configuración integral diseñada para Arch Linux y CachyOS aprovechando la arquitectura modular de **HyDE Project**. Combina la profundidad de un fondo abisal (`#0a0816`) con acentos vibrantes inspirados en nebulosas estelares, cavernas cristalinas y tormentas de plasma de kilonovas.

### 🎨 Especificación de colores

| Rol de color | Hex | Alpha (Hex) | Propósito |
| :--- | :---: | :---: | :--- |
| **Vacío abisal** | `#0a0816` | `#0a0816cc` | Fondo principal y desenfoque de cristal |
| **Superficie de tarjeta** | `#16122c` | `#16122cb3` | Contenedores internos, tarjetas y paneles |
| **Rosa plasma** | `#ff79c6` | `#ff79c6ff` | Bordes activos, acentos e indicadores primarios |
| **Cian cósmico** | `#8be9fd` | `#8be9fdff` | Indicadores de workspace, foco del cursor y chispas |
| **Ámbar solar** | `#ffb86c` | `#ffb86cff` | Alertas de telemetría, métricas y advertencias |
| **Violeta astral** | `#bd93f9` | `#bd93f9ff` | Destellos de cristal y degradados secundarios |
| **Blanco estelar** | `#f8f8f2` | `#f8f8f2ff` | Texto principal de alto contraste |

---

## 🚀 Componentes

- **Hyprland:** Bordes con degradado rotativo de cuatro tonos (`col.active_border`), desenfoque esmerilado de tres pasadas y curvas elásticas fluidas.
- **Waybar:** Tres cápsulas flotantes desacopladas con reflejo especular en el borde superior, morphing de áreas de trabajo, telemetría de hardware y control de volumen.
- **Rofi (theme.dmenu):** Lanzador flotante tipo Spotlight con bordes de neón, desenfoque y campos de selección redondeados.
- **Terminal (Kitty + Fastfetch):** Fondo translúcido con 78% de opacidad, integración del logo galáctico de Arch y paleta espacial ANSI completa.
- **Interfaz del sistema:** Notificaciones translúcidas con Mako, visualizador de audio en degradado con Cava y menú de apagado en cristal con Wlogout.

---

## 📂 Estructura del repositorio

```text
Astral-Void/
├── hypr.theme             # Configuración principal de Hyprland (gaps, bordes, blur, reglas)
├── theme.dmenu            # Plantilla visual para Rofi / Dmenu
├── waybar.theme           # Variables raíz en CSS para paletas de Waybar
├── wallpaper.json         # Metadatos de transición de Swww y paleta base
├── assets/
│   ├── wallpapers/        # Wallpapers espaciales en resolución 4K y 1080p
│   ├── icons/             # arch_galaxy.png (Fastfetch y notificaciones)
│   └── preview.png        # Miniatura para la tarjeta del selector visual de HyDE
├── configs/
│   ├── fastfetch/         # Configuración del sistema y respaldo ASCII en texto
│   ├── kitty/             # Colores, fuentes y opacidad del emulador de terminal
│   ├── mako/              # Reglas y estilos de las alertas del sistema
│   ├── waybar/            # Diseño modular en JSONC y hoja de estilos CSS
│   ├── wlogout/           # Distribución y estilos del menú de energía
│   └── cava/              # Visualizador de espectro de audio en degradado
└── scripts/
    ├── generate_colors.sh # Extractor automático de color (Matugen / Pywal)
    └── post_apply.sh      # Hook de ejecución al activar el tema
