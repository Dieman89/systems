{ config, pkgs, ... }:

let
  theme = import ../shared/theme.nix;
in
{
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";

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
      sed = "gsed";
      assume = "source assume";
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --group-directories-first --git";
      la = "eza -la --icons --group-directories-first --git";
      lt = "eza --tree --icons --level=2";
      lta = "eza --tree --icons --level=2 -a";
      cat = "bat --paging=never";
      catp = "bat";
    };

    sessionVariables = {
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
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
