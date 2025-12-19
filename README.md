# Systems

macOS system configuration using **nix-darwin** and **home-manager**.

## Structure

```md
systems/
├── flake.nix                      # Entry point
├── assets/
│   ├── fonts.zip                  # Custom fonts (Berkeley Mono)
│   └── wallpaper.png              # Desktop wallpaper
├── packages/
│   └── custom-fonts.nix           # Font package derivation
├── scripts/
│   └── update-vscode-extensions.sh  # Update VSCode marketplace extensions
└── modules/
    ├── home-manager/              # User-level config
    │   ├── default.nix            # Core settings & imports
    │   ├── packages/              # Package groups
    │   │   ├── cli.nix            # Shell utilities
    │   │   ├── dev.nix            # Dev tools + languages
    │   │   ├── latex.nix          # LaTeX (for awesome-cv)
    │   │   ├── cloud.nix          # Kubernetes, AWS tools
    │   │   └── fonts.nix          # Fonts
    │   ├── zsh.nix                # Shell + aliases
    │   ├── git.nix                # Git + delta
    │   ├── starship.nix           # Prompt
    │   ├── bat.nix                # Syntax highlighting
    │   ├── direnv.nix             # Auto-load project environments
    │   ├── ghostty.nix            # Terminal config
    │   ├── vscode.nix             # Editor settings + extensions
    │   └── wallpaper.nix          # Desktop wallpaper
    ├── nix-darwin/                # System-level config
    │   ├── default.nix            # Base config + imports
    │   ├── preferences.nix        # macOS system defaults
    │   ├── homebrew.nix           # Homebrew casks
    │   ├── activation.nix         # Activation scripts (default apps, etc.)
    │   └── security.nix           # Touch ID for sudo
    └── shared/
        └── theme.nix              # Monokai Pro Ristretto colors + fonts
```

## What's Included

### CLI Tools (via Nix)

**Shell utilities:** eza, bat, zoxide, ripgrep, fd, jq, yq, htop, tree, gnused, coreutils

**Dev tools:** gh, nil, statix, nixfmt

**Languages:** go, rustup, nodejs, python3, sbt

**Cloud:** kubectl, kubernetes-helm, awscli2, granted

**LaTeX:** texlive

### GUI Apps (via Homebrew)

Zen, Raycast, 1Password, 1Password CLI, Fantastical, Discord, Proton Mail, Proton Drive, ProtonVPN, VS Code, Ghostty, Zed, Docker Desktop, Claude Code, LocalCan, Bruno, Spotify, CleanShot, Eagle, AlDente

### Features

- **direnv + nix-direnv** - Auto-load project environments when entering directories
- **VSCode** - Declarative extensions from nixpkgs and VS Code Marketplace

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

## Linting

Check nix files for issues:

```bash
statix check
```

## Updating VSCode Extensions

Extensions from VS Code Marketplace are pinned with version and sha256 hash. To update them:

```bash
~/systems/scripts/update-vscode-extensions.sh
```

Or use `rebuild-update` which runs this automatically before rebuilding.
