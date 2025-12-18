{ config, pkgs, ... }:

{
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

  # macOS system defaults
  system.defaults = {
    dock = {
      autohide = true;
      autohide-time-modifier = 0.0;
      tilesize = 54;
      largesize = 16;
      magnification = false;
      orientation = "bottom";
      minimize-to-application = true;
      mineffect = "scale";
      show-recents = false;
      mru-spaces = false;

      # Persistent apps in dock (in order)
      persistent-apps = [
        "/Applications/Ghostty.app"
        "/Applications/Visual Studio Code.app"
        "/Applications/Arc.app"
        "/Applications/Proton Mail.app"
        "/Applications/Spotify.app"
      ];

      # Remove Downloads folder and other persistent folders from dock
      persistent-others = [];

      # Hot corners
      # Values: 0=none, 2=mission-control, 3=app-windows, 4=desktop,
      #         5=screensaver, 6=disable-screensaver, 10=sleep-display,
      #         11=launchpad, 12=notification-center, 13=lock-screen, 14=quick-note
      wvous-tl-corner = 5;   # Top-left: Start Screen Saver
      wvous-tr-corner = 12;  # Top-right: Notification Center
      wvous-bl-corner = 11;  # Bottom-left: Launchpad
      wvous-br-corner = 4;   # Bottom-right: Desktop
    };

    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "icnv"; # Icon view
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = false;
      ShowRemovableMediaOnDesktop = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleShowAllExtensions = true;
      # Keyboard
      NSAutomaticCapitalizationEnabled = true;
      NSAutomaticSpellingCorrectionEnabled = true;
      NSAutomaticDashSubstitutionEnabled = true;
      NSAutomaticPeriodSubstitutionEnabled = true;
      NSAutomaticQuoteSubstitutionEnabled = true;
    };

    menuExtraClock = {
      ShowAMPM = true;
      ShowDate = 0; # Don't show date
      ShowDayOfWeek = true;
    };

    trackpad = {
      Clicking = false;
      TrackpadThreeFingerDrag = false;
      TrackpadRightClick = true;
    };

    # Control Center
    controlcenter = {
      BatteryShowPercentage = true;
      Bluetooth = true;
      FocusModes = true;
      NowPlaying = true;
      Sound = true;
    };

    # Screenshot settings
    screencapture = {
      location = "~/Desktop";
      type = "png";
      disable-shadow = false;
    };

    # Window Manager (Stage Manager)
    WindowManager = {
      GloballyEnabled = false;
      HideDesktop = true;
    };

    # Spaces
    spaces = {
      spans-displays = false;
    };
  };

  # Homebrew - for apps not in nixpkgs
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap"; # Remove unlisted casks
      upgrade = true;
    };
    casks = [
      # Browsers
      "arc"
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
 
  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Primary user for user-specific settings
  system.primaryUser = "dieman";

  # Set shell
  programs.zsh.enable = true;

  # Used for backwards compatibility
  system.stateVersion = 5;
}
