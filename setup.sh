#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "==> Installing Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing 1Password CLI..."
if ! command -v op &> /dev/null; then
    brew install --cask 1password-cli
fi

echo "==> Decrypting fonts (optional)..."
if [ ! -f "$SCRIPT_DIR/assets/fonts.zip" ]; then
    "$SCRIPT_DIR/scripts/decrypt.sh" "$SCRIPT_DIR/assets/fonts.zip.age" || echo "    Skipping fonts (requires 1Password access)"
fi

echo "==> Installing Nix..."
if ! command -v nix &> /dev/null; then
    curl -L https://nixos.org/nix/install | sh
    echo "==> Nix installed. Please restart your terminal and run this script again."
    exit 0
fi

echo "==> Enabling flakes..."
mkdir -p ~/.config/nix
grep -q "experimental-features" ~/.config/nix/nix.conf 2>/dev/null || \
    echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

echo "==> Backing up existing shell configs for nix-darwin..."
[ -f /etc/bashrc ] && [ ! -f /etc/bashrc.before-nix-darwin ] && sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
[ -f /etc/zshrc ] && [ ! -f /etc/zshrc.before-nix-darwin ] && sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin

echo "==> Applying nix-darwin configuration..."
if ! command -v darwin-rebuild &> /dev/null; then
    sudo -E nix --extra-experimental-features 'nix-command flakes' --option warn-dirty false run nix-darwin -- switch --flake .#macbook --impure
else
    sudo -E darwin-rebuild switch --flake .#macbook --impure --option warn-dirty false
fi

echo ""
echo "==> Done!"
