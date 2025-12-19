{ config, pkgs, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./git.nix
    ./starship.nix
    ./bat.nix
    ./ghostty.nix
    ./vscode.nix
    ./wallpaper.nix
  ];

  home.stateVersion = "24.05";
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Shell utilities
    eza
    zoxide
    ripgrep
    fd
    jq
    yq
    htop
    tree

    # Development tools
    gh
    gnused
    coreutils

    # Languages & runtimes
    go
    rustup
    nodejs_20
    python3
    sbt

    # Kubernetes & infrastructure
    kubectl
    kubernetes-helm

    # AWS tools
    awscli2
    granted

    # Fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    (pkgs.callPackage ../../packages/custom-fonts.nix { inherit pkgs; })
  ];

  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$GOPATH/bin"
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    EDITOR = "code -w";
    ERL_AFLAGS = "-kernel shell_history enabled";
    GOPATH = "$HOME/go";
  };

  home.activation = {
    createCacheDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p ~/.cache/zsh
    '';
  };
}
