{ config, pkgs, ... }:

let
  theme = import ../shared/theme.nix;
in
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "dieman";
        email = "28837891+Dieman89@users.noreply.github.com";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rerere.enabled = true;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "decorations";
      syntax-theme = "Monokai Extended";
      line-numbers = true;
      side-by-side = false;
      navigate = true;
      dark = true;
      minus-style = "syntax \"#3d2a2d\"";
      minus-emph-style = "syntax \"#5c3035\"";
      plus-style = "syntax \"#2d3a2e\"";
      plus-emph-style = "syntax \"#3d5040\"";
      line-numbers-minus-style = theme.colors.red;
      line-numbers-plus-style = theme.colors.green;
      line-numbers-zero-style = theme.colors.comment;
      hunk-header-style = "file line-number syntax bold";
      hunk-header-decoration-style = "omit";
      file-style = "${theme.colors.cyan} bold";
      file-decoration-style = "none";
    };
  };
}
