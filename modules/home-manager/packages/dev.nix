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
      nodejs_24
      python3
      sbt
      zig
      elixir

      # Linters & formatters
      ruff
      mypy
      golangci-lint
      nodePackages.prettier

      # Tools
      btop
      mise
      pre-commit
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
