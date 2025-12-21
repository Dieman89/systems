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
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqS7RqLVVfENIE1pPs4+6d4TJrK1W7caTEpJXhbno8O";
      };
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rerere.enabled = true;
      fetch.prune = true;
      diff.algorithm = "histogram";
      merge.conflictstyle = "zdiff3";
      branch.sort = "-committerdate";
      column.ui = "auto";

      # 1Password commit signing
      commit.gpgsign = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
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
