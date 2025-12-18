#!/bin/bash
set -e

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

echo "==> Installing Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Applying nix-darwin configuration..."
if ! command -v darwin-rebuild &> /dev/null; then
    nix run nix-darwin -- switch --flake .#macbook
else
    darwin-rebuild switch --flake .#macbook
fi

echo ""
echo "==> Done! Manual steps remaining:"
echo "    1. Install Berkeley Mono font"
echo "    2. Open VS Code and sign in to sync extensions"
