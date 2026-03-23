# Rocko_DE v3

A custom Hyprland desktop with a hand-built Quickshell/QML bar. No pre-made shell — every pill is written from scratch.

## Stack

| Component     | Package              |
|---------------|----------------------|
| OS            | CachyOS              |
| Compositor    | Hyprland             |
| Bar           | Quickshell (QML)     |
| Colors        | Matugen (Material You) |
| Wallpaper     | swww                 |
| Launcher      | Rofi (wayland)       |
| Terminal      | Kitty                |
| Shell         | Fish                 |
| Font          | JetBrains Mono NF    |
| Editor        | Neovim (LazyVim)     |
| Files         | Yazi + Thunar        |
| Idle/Lock     | hypridle + hyprlock  |
| Scratchpads   | pyprland             |
| Notifications | swaync               |

## Bar layout

```
[ Workspaces · Window Title ]  [ Music  Clock ]  [ CPU/GPU  Audio ]
```

All bar components are pill-shaped, color-matched to the current wallpaper via Matugen.

## Panels

| Panel   | Trigger        | Description            |
|---------|----------------|------------------------|
| Audio   | `Super + A`    | Volume sliders, mic    |
| Power   | `Super + X`    | Lock / suspend / reboot / shutdown |
| Keybinds| `Super + /`    | Full keybind reference |

## Install

```bash
git clone https://github.com/ohnoibrokeit/Rocko_DE_v3.git
cd Rocko_DE_v3
bash deploy.sh
```

Requires a fresh CachyOS install with `paru` available.

## Apply a wallpaper

```bash
bash ~/.config/quickshell/rocko/apply.sh ~/Pictures/Wallpapers/ultrawide/mywallpaper.jpg
```

This sets the wallpaper via swww and regenerates all Matugen colors. The bar reloads colors automatically via file watch — no restart needed.

## Post-install

1. Add wallpapers to `~/Pictures/Wallpapers/ultrawide/` and `~/Pictures/Wallpapers/4k/`
2. Apply a wallpaper with `apply.sh`
3. Run `qt6ct` and select a color scheme
4. Reboot

## File layout

```
Rocko_DE_v3/
├── shell/
│   ├── shell.qml           # Quickshell entry point
│   ├── Colors.qml          # Matugen color singleton
│   ├── Pill.qml            # Reusable pill container
│   ├── TopBar.qml          # Bar layout
│   ├── WorkspacesPill.qml  # Workspaces + window title
│   ├── ClockPill.qml       # Clock + date
│   ├── MusicPill.qml       # MPRIS album art + controls
│   ├── SystemStatsPill.qml # CPU + GPU usage/temp
│   ├── AudioPill.qml       # Volume + mic + sample rate
│   ├── AudioPanel.qml      # Audio panel (Super+A)
│   ├── PowerPanel.qml      # Power menu (Super+X)
│   ├── KeybindsPanel.qml   # Keybind reference (Super+/)
│   └── apply.sh            # Wallpaper + color apply script
├── hypr/
│   ├── hyprland.conf
│   └── conf/
│       ├── monitors.conf
│       ├── keybinds.conf
│       ├── windowrules.conf
│       └── animations.conf
├── hypridle/
│   └── hypridle.conf
├── kitty/
│   └── kitty.conf
├── fish/
│   └── config.fish
├── rofi/
├── fastfetch/
├── yazi/
├── nvim/
├── udev/
│   └── 99-nuphy.rules
└── deploy.sh
```

## Key bindings

| Key | Action |
|-----|--------|
| `Super + T` | Terminal |
| `Super + B` | Browser |
| `Super + E` | File manager |
| `Super + D` | App launcher |
| `Super + Q` | Close window |
| `Super + F` | Fullscreen |
| `Super + Space` | Float toggle |
| `Super + X` | Power menu |
| `Super + A` | Audio panel |
| `Super + /` | Keybind cheatsheet |
| `Super + Shift + W` | Random wallpaper |
| `Super + `` ` | Scratchpad terminal |
| `Super + F1` | Scratchpad files |
| `Super + I` | Idle inhibitor toggle |
| `Super + L` | Lock screen |
| `Super + 1-9` | Switch workspace |
| `Super + Shift + 1-9` | Move window to workspace |
