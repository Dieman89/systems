{ pkgs, themeName, ... }:

let
  theme = import ../shared/theme.nix themeName;
  helpers = import ../shared/helpers.nix { inherit pkgs; };
  c = theme.colors;

  baseSettings = {
    font-family = theme.font.familyCondensed;
    font-size = 13;
    window-padding-x = 10;
    window-padding-y = 8;
    cursor-style = "block";
    cursor-style-blink = false;
    quick-terminal-position = "top";
    quick-terminal-screen = "main";
    quick-terminal-animation-duration = "0.1";
    keybind = [
      "global:super+shift+w=toggle_quick_terminal"
    ];
  };

  themeSettings = baseSettings // {
    background = c.bg;
    foreground = c.fg;
    cursor-color = c.cursor;
    cursor-text = c.cursorText;
    selection-background = c.selection;
    selection-foreground = c.fg;

    palette = [
      "0=${c.bg}"
      "1=${c.red}"
      "2=${c.green}"
      "3=${c.yellow}"
      "4=${c.orange}"
      "5=${c.purple}"
      "6=${c.cyan}"
      "7=${c.fg}"
      "8=${c.comment}"
      "9=${c.red}"
      "10=${c.green}"
      "11=${c.yellow}"
      "12=${c.orange}"
      "13=${c.purple}"
      "14=${c.cyan}"
      "15=${c.fg}"
    ];
  };
in
{
  programs.ghostty = {
    enable = true;
    package = helpers.mkFakePkg "ghostty";
    enableZshIntegration = true;
    installBatSyntax = false;

    settings = themeSettings;
  };
}
