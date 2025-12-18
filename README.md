# Systems

macOS system configuration using **nix-darwin** and **home-manager**.

## Structure

```md
systems/
├── flake.nix                      # Entry point
└── modules/
    ├── home-manager/              # User-level config
    │   ├── default.nix            # Packages & imports
    │   ├── zsh.nix                # Shell
    │   ├── git.nix                # Git + delta
    │   ├── starship.nix           # Prompt
    │   ├── bat.nix                # Syntax highlighting
    │   ├── ghostty.nix            # Terminal config
    │   └── vscode.nix             # Editor settings
    ├── nix-darwin/                # System-level config
    │   └── default.nix            # macOS settings + Homebrew
    └── shared/
        └── theme.nix              # Monokai Pro Ristretto colors
```

## What's Included

### CLI Tools (via Nix)

eza, bat, zoxide, ripgrep, fd, jq, yq, htop, tree, delta, git, gh, gnused, coreutils, go, rustup, nodejs, awscli2, granted

### GUI Apps (via Homebrew)

Arc, Raycast, 1Password, Craft, Fantastical, Discord, Proton Mail, VS Code, Ghostty, Zed, Spotify

### macOS Settings

- Dock: autohide, size 54px, scale effect
- Hot corners: Screensaver, Notification Center, Launchpad, Desktop
- Dark mode, Touch ID for sudo
- Finder, trackpad, keyboard preferences

### Theme

**Monokai Pro Ristretto** everywhere with **Berkeley Mono** font.

## Setup on a New Mac

```bash
git clone https://github.com/Dieman89/systems.git ~/systems
cd ~/systems
./setup.sh
```

The script installs Nix, Homebrew, and applies the configuration. You may need to restart your terminal and run it twice (once to install Nix, once to apply config).

## Daily Usage

After initial setup, apply changes with:

```bash
darwin-rebuild switch --flake ~/systems#macbook
```

## Manual Steps

1. **Berkeley Mono font** - paid, install manually
2. **VS Code extensions** - use Settings Sync or install manually:
   - Monokai Pro, GitHub Copilot, Go, Python, Prettier,

## Updating

```bash
cd ~/systems
git pull
darwin-rebuild switch --flake .#macbook
```
 