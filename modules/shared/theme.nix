# Theme selector - pass themeName to get the selected theme
# Available themes: monokai-ristretto, catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
themeName:

let
  themes = import ./themes.nix;
  selected = themes.${themeName} or themes.monokai-ristretto;
in
{
  inherit themeName;
  inherit (selected)
    name
    isDark
    colors
    diff
    apps
    ;

  font = {
    family = "Berkeley Mono, JetBrainsMono Nerd Font";
    familyCondensed = "Berkeley Mono SemiCondensed, JetBrainsMono Nerd Font";
  };
}
