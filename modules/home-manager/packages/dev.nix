{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      # Development tools
      gh

      # Nix tools
      nil # Nix language server (VSCode)
      nixd # Nix language server (Zed)
      statix # Nix linter
      nixfmt-rfc-style # Nix formatter

      # Languages & runtimes
      go
      rustup
      nodejs_20
      python3
      sbt
    ];

    sessionPath = [
      "$HOME/.cargo/bin"
      "$GOPATH/bin"
      "$HOME/.local/bin"
    ];

    sessionVariables = {
      GOPATH = "$HOME/go";
    };
  };
}
