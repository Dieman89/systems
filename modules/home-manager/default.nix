{ lib, ... }:

{
  imports = [
    # Shell & tools
    ./zsh.nix
    ./git.nix
    ./ssh.nix
    ./starship.nix
    ./bat.nix
    ./direnv.nix
    ./atuin.nix
    ./mise.nix

    # Apps
    ./ghostty.nix
    ./vscode.nix
    ./zed.nix
    ./borders.nix
    ./istherenet.nix
    ./btop.nix
    ./k9s.nix

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

    file.".hushlogin".text = "";

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
