_:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;  # Faster nix integration with caching

    # Silence the direnv loading messages (less noise)
    config = {
      global = {
        hide_env_diff = true;
      };
    };

    # Standard library extensions
    stdlib = ''
      # Auto-detect and use .nvmrc, .node-version, etc.
      use_nvm() {
        local version
        version="$1"
        if [[ -f .nvmrc ]]; then
          version=$(cat .nvmrc)
        elif [[ -f .node-version ]]; then
          version=$(cat .node-version)
        fi
        if [[ -n "$version" ]]; then
          use nix -p "nodejs_$version"
        fi
      }
    '';
  };
}
