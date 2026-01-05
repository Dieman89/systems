{ pkgs, lib, ... }:

{
  home = {
    # Setup rustup toolchain and targets after activation
    activation.rustup = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${pkgs.rustup}/bin:$PATH"
      if ! ${pkgs.rustup}/bin/rustup show active-toolchain &>/dev/null; then
        ${pkgs.rustup}/bin/rustup default stable
      fi
      ${pkgs.rustup}/bin/rustup target add wasm32-unknown-unknown 2>/dev/null || true
    '';

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
      elixir-ls # Elixir language server

      # Linters & formatters
      ruff
      mypy
      golangci-lint
      # prettier bundled with wrangler

      # Tools
      btop
      mise
      pre-commit
      wrangler
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
