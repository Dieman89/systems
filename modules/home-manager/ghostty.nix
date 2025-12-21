{ pkgs, ... }:

let
  theme = import ../shared/theme.nix;
  helpers = import ../shared/helpers.nix { inherit pkgs; };
in
{
  programs.ghostty = {
    enable = true;
    package = helpers.mkFakePkg "ghostty";
    enableZshIntegration = true;
    installBatSyntax = false;

    settings = {
      # Font
      font-family = theme.font.familyCondensed;
      font-size = 13;

      # Window
      window-padding-x = 10;
      window-padding-y = 8;

      # Cursor
      cursor-style = "block";
      cursor-style-blink = false;

      # Colors - Monokai Pro Ristretto
      background = theme.colors.bg;
      foreground = theme.colors.fg;
      cursor-color = theme.colors.cursor;
      cursor-text = theme.colors.cursorText;
      selection-background = theme.colors.selection;
      selection-foreground = theme.colors.fg;

      # Palette
      palette = [
        "0=${theme.colors.bg}"
        "1=${theme.colors.red}"
        "2=${theme.colors.green}"
        "3=${theme.colors.yellow}"
        "4=${theme.colors.orange}"
        "5=${theme.colors.purple}"
        "6=${theme.colors.cyan}"
        "7=${theme.colors.fg}"
        "8=${theme.colors.comment}"
        "9=${theme.colors.red}"
        "10=${theme.colors.green}"
        "11=${theme.colors.yellow}"
        "12=${theme.colors.orange}"
        "13=${theme.colors.purple}"
        "14=${theme.colors.cyan}"
        "15=${theme.colors.fg}"
      ];

      # Quick Terminal
      quick-terminal-position = "top";
      quick-terminal-screen = "main";
      quick-terminal-animation-duration = "0.1";

      # Keybinds
      keybind = [
        "global:super+shift+w=toggle_quick_terminal"
      ];
    };
  };
}
