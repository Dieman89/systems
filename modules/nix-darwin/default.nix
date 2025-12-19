{ pkgs, username, ... }:

{
  imports = [
    ./preferences.nix
    ./homebrew.nix
    ./activation.nix
    ./security.nix
  ];

  # Nix settings
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "@admin"
    ];
  };

  # Garbage collection - runs weekly, removes generations older than 30 days
  nix.gc = {
    automatic = true;
    interval = { Weekday = 0; Hour = 3; Minute = 0; }; # Sunday 3am
    options = "--delete-older-than 30d";
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
