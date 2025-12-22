{ username, ... }:

{
  system.defaults = {
    dock = {
      autohide = true;
      autohide-time-modifier = 0.0;
      tilesize = 45;
      largesize = 16;
      magnification = false;
      orientation = "left";
      minimize-to-application = true;
      mineffect = "scale";
      show-recents = false;
      mru-spaces = false;
      static-only = true;

      # Persistent apps in dock (in order)
      persistent-apps = [
        "/Applications/Ghostty.app"
        "/Applications/Visual Studio Code.app"
        "/Users/${username}/Applications/Home Manager Apps/Zen Browser (Beta).app"
        "/Applications/Proton Mail.app"
      ];

      persistent-others = [ ];
      wvous-tl-corner = 5;
      wvous-tr-corner = 12;
      wvous-bl-corner = 11;
      wvous-br-corner = 4;
    };

    finder = {
      AppleShowAllExtensions = true;
      ShowPathbar = true;
      ShowStatusBar = true;
      FXPreferredViewStyle = "icnv";
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = false;
      ShowRemovableMediaOnDesktop = true;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
      FXEnableExtensionChangeWarning = false;
      QuitMenuItem = true;
    };

    loginwindow = {
      GuestEnabled = false;
      DisableConsoleAccess = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleIconAppearanceTheme = "TintedDark";
      AppleShowAllExtensions = true;
      AppleICUForce24HourTime = true;
      AppleShowScrollBars = "WhenScrolling";
      NSWindowShouldDragOnGesture = true; # Drag windows with Ctrl+Cmd+click anywhere
      # Keyboard
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      ApplePressAndHoldEnabled = false;
      "com.apple.keyboard.fnState" = true;
      NSAutomaticCapitalizationEnabled = true;
      NSAutomaticSpellingCorrectionEnabled = true;
      NSAutomaticDashSubstitutionEnabled = true;
      NSAutomaticPeriodSubstitutionEnabled = true;
      NSAutomaticQuoteSubstitutionEnabled = true;
      # Disable natural scrolling (invert scroll direction)
      "com.apple.swipescrolldirection" = false;
    };

    menuExtraClock = {
      Show24Hour = false;
      ShowAMPM = true;
      ShowDate = 2; # 0=When space allows, 1=Always, 2=Never
      ShowDayOfWeek = false;
      ShowSeconds = true;
      FlashDateSeparators = false;
      IsAnalog = false;
    };

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
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
      EnableStandardClickToShowDesktop = false; # Don't hide windows when clicking desktop
    };

    # Spaces
    spaces = {
      spans-displays = false;
    };

    # Raycast - set Cmd+Space as global hotkey
    CustomUserPreferences = {
      "com.raycast.macos" = {
        raycastGlobalHotkey = "Command-49";
      };
      "com.lwouis.alt-tab-macos" = {
        # Shortcut 1: Cmd+Tab for all windows
        holdShortcut = "⌘";
        nextWindowShortcut = "⇥";
        appsToShow = 0; # All apps
        # Shortcut 2: Alt+Tab for active app windows only
        holdShortcut2 = "⌥";
        nextWindowShortcut2 = "⇥";
        appsToShow2 = 1; # Active app only
        # Appearance: Titles style, Medium size, System theme
        appearanceStyle = 2; # Titles
        appearanceSize = 1; # Medium
        appearanceTheme = 2; # System
      };
      # Icon tint color, accent color, and highlight color
      NSGlobalDomain = {
        AppleAccentColor = 0; # Red
        AppleHighlightColor = "1.000000 0.953801 0.931176";
        AppleIconAppearanceTintColor = "Other";
        AppleIconAppearanceCustomTintColor = "1.000000 0.953801 0.931176 0.656030";
      };
      "com.apple.AppleMultitouchTrackpad" = {
        TrackpadThreeFingerDrag = true;
        Dragging = true;
      };
      "com.apple.driver.AppleBluetoothMultitouch.trackpad" = {
        TrackpadThreeFingerDrag = true;
        Dragging = true;
      };
      # Disable automatic macOS updates
      "com.apple.SoftwareUpdate" = {
        AutomaticallyInstallMacOSUpdates = false;
      };
      # Bartender - basic preferences only
      # Triggers and menu bar layout must be configured manually (see README)
      "com.surteesstudios.Bartender" = {
        "launchAtLogin.isEnabled" = true;
        ReduceMenuItemSpacing = true;
        ReduceUpdateCheckFrequencyWhenOnBattery = true;
        SUAutomaticallyUpdate = false;
        SUEnableAutomaticChecks = true;
        ShowDivider = true;
        UseBartenderBar = true;
        MouseOverMenuBarTogglesBartender = false;
        MouseExitDelay = "0.4";
        ShowAllItemsWhenDragging = true;
        HideItemsWhenShowingOthers = false;
        MenuBarShape = "bar";
      };
    };
  };
}
