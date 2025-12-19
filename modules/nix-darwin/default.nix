{ config, pkgs, username, ... }:

{
  imports = [
    ./preferences.nix
    ./homebrew.nix
    ./activation.nix
    ./security.nix
  ];

  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "root" "@admin" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages (available system-wide)
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  # Primary user for user-specific settings
  system.primaryUser = username;

  # Set shell
  programs.zsh.enable = true;

  # Used for backwards compatibility
  system.stateVersion = 5;
}
