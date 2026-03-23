#!/usr/bin/env bash
# ============================================================
#  Rocko_DE v3 — Deploy Script
#  CachyOS + Hyprland + Quickshell custom bar
#
#  Usage:
#    git clone https://github.com/ohnoibrokeit/Rocko_DE_v3.git
#    cd Rocko_DE_v3 && bash deploy.sh
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" && pwd)"
CONFIG="$HOME/.config"
SHELL_DEST="$CONFIG/quickshell/rocko"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()    { echo -e "${BLUE}→${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}⚠${NC} $1"; }
error()   { echo -e "${RED}✗${NC} $1"; exit 1; }

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       Rocko_DE v3 — Deploy Script        ║${NC}"
echo -e "${BLUE}║  CachyOS + Hyprland + Quickshell         ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════╝${NC}"
echo ""

# ── Sanity check ─────────────────────────────────────────────
if ! command -v paru &>/dev/null; then
    error "paru not found. Install it first: https://github.com/Morganamilo/paru"
fi

# ── 1. Packages ───────────────────────────────────────────────
info "Installing packages..."
PACKAGES=(
    # Compositor
    hyprland
    hypridle
    pyprland
    hyprpolkitagent

    # Quickshell runtime
    quickshell

    # Color pipeline
    matugen

    # Wallpaper
    swww

    # Launcher
    rofi-wayland

    # Terminal
    kitty
    fish

    # Fetch
    fastfetch

    # Font
    ttf-jetbrains-mono-nerd

    # File listing
    eza

    # File manager
    yazi
    thunar

    # Editor
    neovim

    # Clipboard
    cliphist
    wl-clipboard
    wl-clip-persist

    # Screenshots
    grim
    slurp
    satty

    # Theming
    adw-gtk-theme
    qt6ct
    papirus-icon-theme

    # System
    brightnessctl
    playerctl
    kdeconnect

    # Notifications (external, until native impl done)
    swaync
)
paru -S --needed --noconfirm "${PACKAGES[@]}"
success "Packages installed"

# ── 2. Directory structure ────────────────────────────────────
info "Creating directories..."
mkdir -p "$SHELL_DEST"
mkdir -p "$CONFIG/hypr/conf"
mkdir -p "$CONFIG/hypr/scripts"
mkdir -p "$CONFIG/kitty"
mkdir -p "$CONFIG/fish"
mkdir -p "$CONFIG/rofi"
mkdir -p "$CONFIG/fastfetch"
mkdir -p "$CONFIG/yazi"
mkdir -p "$CONFIG/nvim/lua"
mkdir -p "$HOME/.cache/matugen"
mkdir -p "$HOME/Pictures/Wallpapers/ultrawide"
mkdir -p "$HOME/Pictures/Wallpapers/4k"
success "Directories created"

# ── 3. Quickshell config ──────────────────────────────────────
info "Deploying Quickshell bar..."
cp -r "$SCRIPT_DIR"/shell/* "$SHELL_DEST/"
chmod +x "$SHELL_DEST/apply.sh" 2>/dev/null || true
success "Quickshell config deployed → $SHELL_DEST"

# ── 4. Hyprland config ────────────────────────────────────────
info "Deploying Hyprland config..."
cp "$SCRIPT_DIR/hypr/hyprland.conf"         "$CONFIG/hypr/hyprland.conf"
cp "$SCRIPT_DIR/hypr/conf/monitors.conf"    "$CONFIG/hypr/conf/"
cp "$SCRIPT_DIR/hypr/conf/keybinds.conf"    "$CONFIG/hypr/conf/"
cp "$SCRIPT_DIR/hypr/conf/windowrules.conf" "$CONFIG/hypr/conf/"
cp "$SCRIPT_DIR/hypr/conf/animations.conf"  "$CONFIG/hypr/conf/"
cp "$SCRIPT_DIR/hypr/scripts/"*             "$CONFIG/hypr/scripts/"
chmod +x "$CONFIG/hypr/scripts/"*
success "Hyprland config deployed"

# ── 5. hypridle ───────────────────────────────────────────────
info "Deploying hypridle config..."
mkdir -p "$CONFIG/hypr"
cp "$SCRIPT_DIR/hypridle/hypridle.conf" "$CONFIG/hypr/hypridle.conf"
success "hypridle deployed"

# ── 6. Kitty ─────────────────────────────────────────────────
info "Deploying Kitty config..."
cp "$SCRIPT_DIR/kitty/kitty.conf" "$CONFIG/kitty/kitty.conf"
success "Kitty deployed"

# ── 7. Fish shell ─────────────────────────────────────────────
info "Deploying fish config..."
cp "$SCRIPT_DIR/fish/config.fish" "$CONFIG/fish/config.fish"
if [[ "$SHELL" != "$(which fish)" ]]; then
    chsh -s "$(which fish)"
    success "fish set as default shell (re-login to take effect)"
else
    success "fish already default shell"
fi

# ── 8. Fastfetch ──────────────────────────────────────────────
info "Deploying fastfetch config..."
cp "$SCRIPT_DIR/fastfetch/config.jsonc" "$CONFIG/fastfetch/config.jsonc"
warn "Add avatar to ~/.config/fastfetch/avatar.png manually"
success "fastfetch deployed"

# ── 9. Rofi ───────────────────────────────────────────────────
info "Deploying rofi config..."
cp -r "$SCRIPT_DIR/rofi/"* "$CONFIG/rofi/"
success "Rofi deployed"

# ── 10. Yazi ─────────────────────────────────────────────────
info "Deploying yazi config..."
cp -r "$SCRIPT_DIR/yazi/"* "$CONFIG/yazi/"
success "Yazi deployed"

# ── 11. Neovim ───────────────────────────────────────────────
info "Deploying nvim config..."
cp -r "$SCRIPT_DIR/nvim/"* "$CONFIG/nvim/"
success "Neovim deployed"

# ── 12. NuPhy udev rule ───────────────────────────────────────
if [[ -f "$SCRIPT_DIR/udev/99-nuphy.rules" ]]; then
    info "Installing NuPhy udev rule..."
    sudo cp "$SCRIPT_DIR/udev/99-nuphy.rules" /etc/udev/rules.d/
    sudo udevadm control --reload-rules
    sudo udevadm trigger
    success "NuPhy udev rule installed"
fi

# ── 13. GTK/Qt theming ────────────────────────────────────────
info "Applying GTK/Qt defaults..."
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' 2>/dev/null || true
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark' 2>/dev/null || true
gsettings set org.gnome.desktop.interface font-name 'Noto Sans 11' 2>/dev/null || true
success "GTK defaults set"

# ── Done ──────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║            Deploy complete!              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
echo ""
echo "Post-install steps:"
echo "  1. Add wallpapers → ~/Pictures/Wallpapers/ultrawide/ and .../4k/"
echo "  2. Run: bash ~/.config/quickshell/rocko/apply.sh <wallpaper>"
echo "  3. Run qt6ct and set color scheme"
echo "  4. Reboot"
echo ""
