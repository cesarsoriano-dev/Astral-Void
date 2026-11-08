Astral Void — Ecosistema Cosmic Glassmorphism para HyDE & Hyprland
==================================================================

![Arch Linux](https://img.shields.io/badge/Arch_Linux_/_CachyOS-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/Hyprland-58E1FF?style=for-the-badge&logo=hyprland&logoColor=0a0816)
![HyDE Project](https://img.shields.io/badge/HyDE_Ecosystem-bd93f9?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-50fa7b?style=for-the-badge)

**Idiomas:** [English](README.md) | [Español](README.es.md)

**Astral Void** es un ecosistema completo de nivel de producción con estética *Cosmic Glassmorphism* diseñado para **Hyprland** y **HyDE Project** (Arch Linux / CachyOS). Construido sobre una base abisal de espacio profundo (`0a0816`), bordes espectrales de titanio y acentos de nebulosa, garantiza un contraste tipográfico perfecto incluso sobre fondos de supernova hiperbrillantes.

Galería Visual
--------------

Coloca tus capturas de pantalla dentro de `assets/previews/` (`overview.png`, `lockscreen.png`, `terminals.png`) para mostrar tu entorno:

![Vista General de Astral Void](assets/previews/overview.png)

Ecosistema Completo de 15 Módulos
---------------------------------

A diferencia de los temas básicos, **Astral Void** estiliza cada capa de tu flujo de trabajo en Linux de forma nativa:

1. **Waybar (Arquitectura de Micro-Cápsulas Flotantes):** Contenedores modulares GTK3 (`group/capsule-*`) con bordes espectrales de titanio de 1px, divisores internos y espacio de trabajo activo en gradiente angular.
2. **Compositor Hyprland (`hypr.theme`):** Desenfoque calibrado de 3 pasadas (`size = 8`, `passes = 3`), bordes espectrales animados y reglas de opacidad inteligente.
3. **Suite Multi-Terminal (`Kitty`, `Alacritty`, `Foot`):** Capas alfa ahumadas al `0.78` y paleta TrueColor fija inmune al lavado visual de Wallbash.
4. **Motor Dinámico Fastfetch con 9 Iconos Cósmicos:** Rota automáticamente entre tus 9 emblemas espaciales en `assets/icons/` cada vez que abres la terminal o cambias de wallpaper.
5. **Lanzador de Aplicaciones Rofi (`config.rasi`):** Ventana flotante de cristal ahumado con barra de búsqueda en píldora y selección en *Pulsar Violet*.
6. **Centro de Notificaciones Dunst (`dunstrc`):** Burbujas espaciales con bordes según nivel de urgencia y barras de progreso en *Horizon Cyan* para volumen y brillo.
7. **Pantalla de Bloqueo Sci-Fi (`hyprlock.conf`):** Arquitectura de triple escudo de contraste, dock inferior de telemetría de batería/AC en vivo y anillo de avatar central dinámico.
8. **Menú de Energía (`wlogout`):** Tarjetas vectoriales independientes de resolución con iluminación semántica al pasar el cursor.
9. **Prompt de Terminal Starship (`starship.toml`):** Micro-cápsulas Powerline coordinadas con tu Waybar e indicadores de Git y lenguajes de programación.
10. **Monitor de Hardware Btop++ (`astral-void.theme`):** Gráficas térmicas y de procesos con gradientes desde *Horizon Cyan* hasta *Supernova Red*.
11. **Visualizador de Audio Cava (`cava/config`):** Espectro musical a 60 FPS con suavizado Monstercat y gradiente vertical de 6 niveles.
12. **Integración GTK3, GTK4 y Qt/Kvantum:** Barras laterales translúcidas y modo oscuro unificado para **Dolphin**, **Thunar**, **Nautilus**, **Pavucontrol** y **Blueman**.

Paleta Cromática Oficial
------------------------

| Rol | Nombre | Hex / RGB / RGBA |
| :--- | :--- | :--- |
| Base Abisal | Fondo de Espacio Profundo | `0a0816` / `rgb(10, 8, 22)` |
| Cristal Cósmico | Superficie de Cápsulas y Terminal | `rgba(10, 8, 22, 0.78)` |
| Módulo Interno | Superficie Interna de Píldora | `120e26` / `rgba(18, 14, 38, 0.65)` |
| Luz Estelar | Texto Principal | `f8f8f2` / `rgb(248, 248, 242)` |
| Nebulosa Atenuada | Elementos Inactivos | `6272a4` / `rgb(98, 114, 164)` |
| Violeta Púlsar | Acento Primario / Ventana Activa | `bd93f9` / `rgb(189, 147, 249)` |
| Borde Titanio | Contorno Espectral de Cápsulas | `rgba(189, 147, 249, 0.28)` |
| Cian Horizonte | Interactividad Hover / Cursor | `8be9fd` / `rgb(139, 233, 253)` |
| Supernova Magenta | Lanzador / Botón de Energía | `ff79c6` / `rgb(255, 121, 198)` |
| Rojo Supernova | Alerta Crítica / Audio Silenciado | `ff5555` / `rgb(255, 85, 85)` |
| Ámbar Estelar | Estado de Advertencia / Brillo | `ffb86c` / `rgb(255, 184, 108)` |
| Esmeralda Cósmico | Red Óptima / Batería Cargando | `50fa7b` / `rgb(80, 250, 123)` |

Arquitectura del Repositorio
----------------------------

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
