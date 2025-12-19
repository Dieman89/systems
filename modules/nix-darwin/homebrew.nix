{ config, pkgs, ... }:

{
  # Add Homebrew to PATH
  environment.systemPath = [ "/opt/homebrew/bin" ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Remove unlisted casks
      upgrade = true;
    };
    casks = [
      # Browsers
      "zen"
      # Productivity
      "raycast"
      "1password"
      "fantastical"
      # Communication
      "discord"
      "proton-mail"
      # Development
      "visual-studio-code"
      "ghostty"
      "zed"
      "docker-desktop"
      "claude-code"
      # Media
      "spotify"
    ];
  };
}
