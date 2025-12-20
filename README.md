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
├── config/
│   ├── vscode/settings.json         # VSCode/Antigravity settings
│   └── zed/settings.json            # Zed editor settings
├── scripts/
│   ├── update-vscode-extensions.sh  # Update VSCode marketplace extensions
│   └── install-antigravity-extensions.sh  # Install extensions into Antigravity
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
    │   ├── vscode.nix             # VSCode/Antigravity settings + extensions
    │   ├── zed.nix                # Zed editor settings
    │   ├── wallpaper.nix          # Desktop wallpaper
    │   └── borders.nix            # Window border highlighting
    ├── nix-darwin/                # System-level config
    │   ├── default.nix            # Base config + imports
    │   ├── preferences.nix        # macOS system defaults
    │   ├── homebrew.nix           # Homebrew casks
    │   ├── activation.nix         # Activation scripts (default apps, etc.)
    │   └── security.nix           # Touch ID for sudo
    └── shared/
        ├── theme.nix              # Monokai Pro Ristretto colors + fonts
        └── helpers.nix            # Shared helper functions
```

## What's Included

### CLI Tools (via Nix)

**Shell utilities:** eza, bat, zoxide, ripgrep, fd, jq, yq, htop, tree, gnused, coreutils, tldr, duf, procs

**Dev tools:** gh, nil, nixd, statix, nixfmt

**Languages:** go, rustup, nodejs, python3, sbt

**Cloud:** kubectl, kubernetes-helm, awscli2, granted

**LaTeX:** texlive

### GUI Apps (via Homebrew)

**Browsers:** Zen

**Productivity:** Raycast, 1Password, 1Password CLI, Fantastical, Craft

**Communication:** Discord, Telegram, WhatsApp, Proton Mail, Proton Drive, ProtonVPN

**Development:** VS Code, Antigravity, Ghostty, Zed, Docker Desktop, Claude Code, Gemini CLI, LocalCan, Bruno

**Media:** Spotify, CleanShot, Eagle

**Utilities:** AlDente, AltTab, Bartender, JankyBorders (window highlighting)

### Features

- **direnv + nix-direnv** - Auto-load project environments when entering directories
- **VSCode + Antigravity** - Declarative extensions from nixpkgs and VS Code Marketplace, shared settings
- **Zed** - Declarative settings with auto-installed extensions
- **AltTab** - Cmd+Tab for all windows, Alt+Tab for current app windows
- **JankyBorders** - Highlight active window with colored borders (Monokai themed)
- **Bartender** - Menu bar management (triggers/layout configured manually, basic prefs via nix)

### macOS Settings

- Dock: autohide, size 54px, scale effect
- Hot corners: Screensaver, Notification Center, Launchpad, Desktop
- Dark mode with tinted icons
- Red accent color with matching text highlight
- Touch ID for sudo, guest login disabled
- Finder: full path in title, quit menu enabled
- Trackpad: tap to click, three-finger drag
- Keyboard: fast repeat, F1-F12 as standard keys
- Raycast as Cmd+Space (Spotlight shortcut disabled)
- Screenshot shortcuts disabled (for CleanShot)
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
rebuild-update   # Update VSCode extensions, apply config, install Antigravity extensions
```

Or manually:

```bash
sudo darwin-rebuild switch --flake ~/systems#macbook
```

## Linting & Formatting

Check nix files for issues:

```bash
nix-lint
```

Format all nix files:

```bash
nix-fmt
```

## Updating

### Nixpkgs and Home Manager

Update flake inputs (nixpkgs, home-manager, nix-darwin) to get newer package versions:

```bash
nix flake update
rebuild
```

This updates extensions from `pkgs.vscode-extensions` and all Nix packages.

### VSCode Marketplace Extensions

Extensions from VS Code Marketplace are pinned with version and sha256 hash. To update them:

```bash
~/systems/scripts/update-vscode-extensions.sh
```

Or use `rebuild-update` which runs this automatically before rebuilding.

## Troubleshooting

### Permission denied errors

If you get permission errors with `nix flake update` or git operations:

```bash
sudo chown -R $(whoami):admin ~/systems
```

This can happen after `sudo darwin-rebuild` modifies files as root. The activation script fixes this automatically, but may need manual intervention if rebuild itself fails.

## Manual Configuration

Some apps require manual setup that can't be declaratively managed via nix.

### Bartender - ProtonVPN Trigger

Show ProtonVPN icon when disconnected from VPN:

1. Open Bartender Settings → Triggers → Add Trigger
2. Name: "Show ProtonVPN if not connected"
3. Show Menu Bar Items: Select "Proton VPN"
4. Add condition: Script
5. Script:
   ```bash
   scutil --nc list | grep -c -e "\\(Disconnected\\).*ProtonVPN"
   ```
6. Run script every: 30 seconds

The script outputs `1` (true) when VPN is disconnected, triggering Bartender to show the icon.
