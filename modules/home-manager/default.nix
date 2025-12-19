{ lib, ... }:

{
  imports = [
    # Shell & tools
    ./zsh.nix
    ./git.nix
    ./starship.nix
    ./bat.nix
    ./direnv.nix

    # Apps
    ./ghostty.nix
    ./vscode.nix
    ./wallpaper.nix
    ./borders.nix

    # Packages
    ./packages/cli.nix
    ./packages/dev.nix
    ./packages/latex.nix
    ./packages/cloud.nix
    ./packages/fonts.nix
  ];

  programs.home-manager.enable = true;

  home = {
    stateVersion = "25.11";

    sessionVariables = {
      EDITOR = "code -w";
      ERL_AFLAGS = "-kernel shell_history enabled";
    };

    activation = {
      createCacheDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p ~/.cache/zsh
      '';
    };
  };
}
