# Systems

macOS system configuration using **nix-darwin** and **home-manager**.

## Structure

```
systems/
├── flake.nix                      # Entry point
├── assets/
│   └── fonts.zip                  # Custom fonts (Berkeley Mono)
├── packages/
│   └── custom-fonts.nix           # Font package derivation
├── scripts/
│   └── update-vscode-extensions.sh  # Update VSCode marketplace extensions
└── modules/
    ├── home-manager/              # User-level config
    │   ├── default.nix            # Packages & imports
    │   ├── zsh.nix                # Shell + aliases
    │   ├── git.nix                # Git + delta
    │   ├── starship.nix           # Prompt
    │   ├── bat.nix                # Syntax highlighting
    │   ├── ghostty.nix            # Terminal config
    │   └── vscode.nix             # Editor settings + extensions
    ├── nix-darwin/                # System-level config
    │   ├── default.nix            # Base config + imports
    │   ├── preferences.nix        # macOS system defaults
    │   ├── homebrew.nix           # Homebrew casks & formulae
    │   ├── activation.nix         # Activation scripts (default apps, etc.)
    │   └── security.nix           # Touch ID for sudo
    └── shared/
        └── theme.nix              # Monokai Pro Ristretto colors + fonts
```

## What's Included

### CLI Tools (via Nix)

eza, bat, zoxide, ripgrep, fd, jq, yq, htop, tree, delta, git, gh, gnused, coreutils, go, rustup, nodejs, python3, sbt, kubectl, kubernetes-helm, awscli2, granted

### GUI Apps (via Homebrew)

Zen, Raycast, 1Password, Craft, Fantastical, Discord, Proton Mail, VS Code, Ghostty, Zed, Spotify

### VSCode Extensions

Managed declaratively via Nix. Includes extensions from nixpkgs and VS Code Marketplace with pinned versions and hashes.

### macOS Settings

- Dock: autohide, size 54px, scale effect
- Hot corners: Screensaver, Notification Center, Launchpad, Desktop
- Dark mode, Touch ID for sudo
- Finder, trackpad, keyboard preferences
- Raycast as Cmd+Space (Spotlight disabled)
- Default apps: Zen (browser), Proton Mail (mailto), Fantastical (calendar)

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

Shell aliases are available after setup:

```bash
rebuild          # Apply nix configuration
rebuild-update   # Update VSCode extensions, then apply config
```

Or manually:

```bash
sudo darwin-rebuild switch --flake ~/systems#macbook
```

## Updating VSCode Extensions

Extensions from VS Code Marketplace are pinned with version and sha256 hash. To update them:

```bash
~/systems/scripts/update-vscode-extensions.sh
```

Or use `rebuild-update` which runs this automatically before rebuilding.
