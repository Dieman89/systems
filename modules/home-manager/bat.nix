{ config, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "Monokai Extended";
      pager = "less -FR";
    };
  };

  home.sessionVariables = {
    BAT_THEME = "Monokai Extended";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };
}
