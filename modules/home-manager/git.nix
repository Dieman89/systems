_:

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
      minus-style = "syntax \"${theme.diff.minus}\"";
      minus-emph-style = "syntax \"${theme.diff.minusEmph}\"";
      plus-style = "syntax \"${theme.diff.plus}\"";
      plus-emph-style = "syntax \"${theme.diff.plusEmph}\"";
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
