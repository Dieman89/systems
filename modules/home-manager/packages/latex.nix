{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Typst
    typst
    tinymist # Language server & linter
    typstyle # Formatter
  ];
}
