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
      "circumflex"
      "ffsend"
      "gemini-cli"
      "thefuck"
    ];
    casks = [
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
      "zed"
      "antigravity"
      "claude-code"
      "ghostty"
      "docker-desktop"
      "localcan"
      "bruno"
      # Media
      "spotify"
      "cleanshot"
      "ogdesign-eagle"
      "iina"
      "blip"
      # Utilities
      "alcove"
      "aldente"
      "alt-tab"
      "bartender"
      "istherenet"
    ];

    # Mac App Store apps
    masApps = {
      "RunCat" = 1429033973;
    };
  };
}
