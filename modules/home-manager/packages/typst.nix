{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Typst
    typst
    # tinymist # Language server & linter - temporarily disabled due to cache issues
    typstyle # Formatter
  ];
}
