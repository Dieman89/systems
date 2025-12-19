_:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "Monokai Extended";
      pager = "less -FR";
    };
    syntaxes = {}; # Disable auto-generated syntaxes
  };

  home.sessionVariables = {
    BAT_THEME = "Monokai Extended";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };
}
