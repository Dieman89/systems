# Systems

<p align="center">
  <img src="screenshots/fastfetch.png" alt="System Screenshot" />
</p>

Declarative macOS configuration using **nix-darwin** and **home-manager**.

## Quick Start

```bash
git clone https://github.com/Dieman89/systems.git ~/systems
cd ~/systems
./setup.sh
```

After setup, use `rebuild` to apply changes.

## What's Included

| Category | Tools |
|----------|-------|
| **Shell** | zsh, starship, atuin, eza, bat, zoxide, ripgrep, fd, fzf, thefuck |
| **Dev** | git, delta, gh, direnv, mise, btop, nil, nixd |
| **Languages** | go, rust, node, python, zig, elixir, sbt |
| **Cloud** | kubectl, helm, k9s, kubectx, terraform, argocd, awscli, granted |
| **Security** | trivy, nmap, age |
| **Apps** | Zen, Ghostty, VS Code, Zed, Raycast, 1Password |

## Theme

Switch themes system-wide with a single command. Uses **Berkeley Mono** font.

### Available Themes

| Theme | Style |
|-------|-------|
| `ristretto` | Monokai Pro Ristretto (warm, dark) - default |
| `latte` | Catppuccin Latte (light) |
| `frappe` | Catppuccin Frappé (muted dark) |
| `macchiato` | Catppuccin Macchiato (medium dark) |
| `mocha` | Catppuccin Mocha (darkest) |

### Switching Themes

```bash
rebuild mocha      # Switch to Catppuccin Mocha
rebuild ristretto  # Switch back to Monokai Ristretto
themes             # Show all available themes
```

Theme applies to: Ghostty, VS Code, Zed, Zen Browser, starship, bat, delta, borders, eza.

### Font Setup

Berkeley Mono is encrypted (paid font). On a new machine, decrypt once:

```bash
./scripts/decrypt.sh assets/fonts.zip.age  # Requires 1Password
```

### Encryption Scripts

```bash
# Encrypt any file (uses public key)
./scripts/encrypt.sh <file>              # Creates <file>.age

# Decrypt any .age file (requires 1Password)
./scripts/decrypt.sh <file.age>          # Creates <file>
```

## Structure

```md
modules/
├── home-manager/     # User config (shell, git, apps)
├── nix-darwin/       # System config (preferences, homebrew)
└── shared/           # Theme colors, helper functions
```

## Manual Setup

### 1Password - SSH & Git Signing

1. 1Password → Settings → Developer
2. Enable "Use the SSH agent" and "Sign Git commits with SSH"
3. Copy your SSH public key
4. Update the key in `modules/home-manager/git.nix`
5. Add the key to GitHub/GitLab

### Raycast - Nix Apps

Add `~/Applications/Home Manager Apps` to Raycast's application search:

Raycast Settings → Extensions → Applications → Add Folder

### Bartender - VPN Indicator

Show ProtonVPN icon when disconnected:

1. Bartender → Triggers → Add Trigger
2. Show: "Proton VPN"
3. Script condition (every 30s):

   ```bash
   scutil --nc list | grep -c -e "\\(Disconnected\\).*ProtonVPN"
   ```

## Development

### Pre-commit Hooks

Install hooks to auto-format and lint before commits:

```bash
pre-commit install
```

### CI

GitHub Actions runs on every push/PR:
- `nix flake check` - validates the flake
- `statix check` - lints nix files
- `nixfmt --check` - checks formatting

## Commands

```bash
rebuild          # Apply configuration (notifies on complete)
rebuild-update   # Update extensions + rebuild
decrypt-fonts    # Decrypt Berkeley Mono (once per machine)
nix-health       # Verify system matches config
nix flake update # Update nix inputs
nix-lint         # Check for issues
nix-fmt          # Format nix files
```

## Troubleshooting

**Permission errors:** `sudo chown -R $(whoami):admin ~/systems`
