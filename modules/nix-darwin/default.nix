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
      AppleReduceDesktopTinting = true;
      NSAutomaticCapitalizationEnabled = true;
      NSAutomaticSpellingCorrectionEnabled = true;
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
  };

  # Enable Touch ID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Set shell
  programs.zsh.enable = true;

  # Used for backwards compatibility
  system.stateVersion = 5;
}
