_:

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
    taps = [
      "FelixKratz/formulae"
    ];
    brews = [
      "borders"
    ];
    casks = [
      # Browsers
      "zen"
      # Productivity
      "raycast"
      "1password"
      "1password-cli"
      "fantastical"
      "craft"
      # Communication
      "discord"
      "telegram"
      "whatsapp"
      "proton-mail"
      "proton-drive"
      "protonvpn"
      # Development
      "visual-studio-code"
      "ghostty"
      "zed"
      "docker-desktop"
      "claude-code"
      "localcan"
      "bruno"
      # Media
      "spotify"
      "cleanshot"
      "ogdesign-eagle"
      # Utilities
      "aldente"
    ];
  };
}
