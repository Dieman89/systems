{ config, themeName, ... }:

let
  theme = import ../shared/theme.nix themeName;
in
{
  programs = {
    zsh = {
      enable = true;
      autocd = true;
      dotDir = "${config.xdg.configHome}/zsh";

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      historySubstringSearch.enable = true;

      history = {
        size = 10000;
        save = 10000;
        path = "${config.xdg.cacheHome}/zsh/history";
        ignoreDups = true;
        ignoreAllDups = true;
        ignoreSpace = true;
        expireDuplicatesFirst = true;
        share = true;
      };

      defaultKeymap = "emacs";

      shellAliases = {
        assume = "source assume";
        ls = "eza --icons --group-directories-first";
        ll = "eza -l --icons --group-directories-first --git";
        la = "eza -la --icons --group-directories-first --git";
        lt = "eza --tree --icons --level=2";
        lta = "eza --tree --icons --level=2 -a";
        cat = "bat --paging=never";
        catp = "bat";
        decrypt-fonts = "~/systems/scripts/decrypt.sh ~/systems/assets/fonts.zip.age";
        nix-fmt = "find ~/systems -name '*.nix' -exec nixfmt {} +";
        nix-lint = "statix check ~/systems";
        nix-health = "~/systems/scripts/health-check.sh";
      };

      sessionVariables = {
        FZF_DEFAULT_OPTS = theme.apps.fzf;
        EZA_COLORS = builtins.concatStringsSep ":" [
          "di=${theme.colors.cyan}"
          "fi=${theme.colors.fg}"
          "ln=${theme.colors.purple}"
          "ex=${theme.colors.green}"
          "ur=${theme.colors.yellow}"
          "uw=${theme.colors.red}"
          "ux=${theme.colors.green}"
          "gr=${theme.colors.yellow}"
          "gw=${theme.colors.red}"
          "gx=${theme.colors.green}"
          "tr=${theme.colors.yellow}"
          "tw=${theme.colors.red}"
          "tx=${theme.colors.green}"
          "da=${theme.colors.comment}"
          "sn=${theme.colors.orange}"
          "sb=${theme.colors.orange}"
          "uu=${theme.colors.orange}"
          "un=${theme.colors.comment}"
          "gu=${theme.colors.orange}"
          "gn=${theme.colors.comment}"
          "ga=${theme.colors.green}"
          "gm=${theme.colors.yellow}"
          "gd=${theme.colors.red}"
          "gv=${theme.colors.purple}"
          "gt=${theme.colors.comment}"
        ];
      };

      initContent = ''
        eval $(thefuck --alias)
        eval "$(mise activate zsh)"

        # Rebuild with optional theme selection
        # Usage: rebuild [theme]
        # Available themes: ristretto (default), latte, frappe, macchiato, mocha
        rebuild() {
          local theme="''${1:-macbook}"
          local notify_success='display notification "Rebuild complete" with title "Nix" sound name "Glass"'
          local notify_fail='display notification "Rebuild failed" with title "Nix" sound name "Basso"'

          if sudo darwin-rebuild switch --flake ~/systems#"$theme"; then
            osascript -e "$notify_success"
          else
            osascript -e "$notify_fail"
            return 1
          fi
        }

        # Rebuild with extension updates
        rebuild-update() {
          local theme="''${1:-macbook}"
          ~/systems/scripts/update-vscode-extensions.sh
          rebuild "$theme" && ~/systems/scripts/install-antigravity-extensions.sh
        }

        # Show available themes
        themes() {
          echo "Available themes:"
          echo "  ristretto  - Monokai Pro Ristretto (warm, dark)"
          echo "  latte      - Catppuccin Latte (light)"
          echo "  frappe     - Catppuccin Frappé (muted dark)"
          echo "  macchiato  - Catppuccin Macchiato (medium dark)"
          echo "  mocha      - Catppuccin Mocha (darkest)"
          echo ""
          echo "Usage: rebuild [theme]"
          echo "Example: rebuild mocha"
        }

        # Kill process on a specific port
        killport() {
          if [ -z "$1" ]; then
            echo "Usage: killport <port>"
            return 1
          fi
          lsof -ti:"$1" | xargs kill -9 2>/dev/null && echo "Port $1 freed" || echo "No process on port $1"
        }

        # View process on a specific port
        viewport() {
          if [ -z "$1" ]; then
            echo "Usage: viewport <port>"
            return 1
          fi
          lsof -i:"$1" || echo "No process on port $1"
        }
      '';
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
