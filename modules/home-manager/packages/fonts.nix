{ pkgs, ... }:

let
  fontsZipExists = builtins.pathExists ../../../assets/fonts.zip;
  customFonts = pkgs.callPackage ../../../packages/custom-fonts.nix { inherit pkgs; };
in
{
  home.packages =
    with pkgs;
    [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      font-awesome
      source-sans-pro
    ]
    ++ (if fontsZipExists then [ customFonts ] else [ ]);
}
