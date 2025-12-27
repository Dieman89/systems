{ themeName, ... }:

let
  theme = import ../shared/theme.nix themeName;
in
{
  programs.bat = {
    enable = true;
    config = {
      theme = theme.apps.bat;
      pager = "less -FR";
    };
  };

  home.sessionVariables = {
    BAT_THEME = theme.apps.bat;
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };
}
