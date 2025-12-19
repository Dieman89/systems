{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    (pkgs.callPackage ../../../packages/custom-fonts.nix { inherit pkgs; })
  ];
}
