{ pkgs, ... }:

{
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
    gnused
    coreutils
  ];
}
