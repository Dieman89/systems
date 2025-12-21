{ inputs, ... }:

let
  theme = import ../shared/theme.nix;
  c = theme.colors;
  bgLighter = "#403838";

  userChrome = ''
    :root {
      --zen-colors-primary: ${c.selection} !important;
      --zen-primary-color: ${c.orange} !important;
      --zen-colors-secondary: ${c.selection} !important;
      --zen-colors-tertiary: ${bgLighter} !important;
      --zen-colors-border: ${c.orange} !important;
      --toolbarbutton-icon-fill: ${c.orange} !important;
      --lwt-text-color: ${c.fg} !important;
      --toolbar-field-color: ${c.fg} !important;
      --tab-selected-textcolor: ${c.fg} !important;
      --toolbar-field-focus-color: ${c.fg} !important;
      --newtab-text-primary-color: ${c.fg} !important;
      --arrowpanel-color: ${c.fg} !important;
      --arrowpanel-background: ${c.bg} !important;
      --sidebar-text-color: ${c.fg} !important;
      --lwt-sidebar-text-color: ${c.fg} !important;
      --lwt-sidebar-background-color: ${c.bg} !important;
      --toolbar-bgcolor: ${c.selection} !important;
      --newtab-background-color: ${c.bg} !important;
      --zen-themed-toolbar-bg: ${c.bg} !important;
      --zen-main-browser-background: ${c.bg} !important;
      --toolbox-bgcolor-inactive: ${bgLighter} !important;
    }

    #permissions-granted-icon { color: ${c.fg} !important; }
    .sidebar-placesTree { background-color: ${c.bg} !important; }
    #zen-workspaces-button { background-color: ${c.bg} !important; }
    #TabsToolbar { background-color: ${c.bg} !important; }
    .urlbar-background { background-color: ${c.selection} !important; }
    .content-shortcuts { background-color: ${c.bg} !important; border-color: ${c.orange} !important; }
    .urlbarView-url { color: ${c.orange} !important; }
    #urlbar-input::selection,
    .urlbar-input::selection,
    #urlbar input::selection,
    #urlbar-input-container input::selection {
      background-color: ${c.orange} !important;
      color: ${c.fg} !important;
    }
    #zenEditBookmarkPanelFaviconContainer { background: ${c.bg} !important; }
    hbox#titlebar { background-color: ${c.bg} !important; }
    #zen-appcontent-navbar-container { background-color: ${c.bg} !important; }
    #contentAreaContextMenu menu, menuitem, menupopup { color: ${c.fg} !important; }

    #zen-media-controls-toolbar {
      & #zen-media-progress-bar {
        &::-moz-range-track { background: ${c.selection} !important; }
      }
    }

    toolbar .toolbarbutton-1 {
      &:not([disabled]) {
        &:is([open], [checked]) > :is(.toolbarbutton-icon, .toolbarbutton-text, .toolbarbutton-badge-stack) {
          fill: ${c.bg};
        }
      }
    }

    .identity-color-blue { --identity-tab-color: ${c.cyan} !important; --identity-icon-color: ${c.cyan} !important; }
    .identity-color-turquoise { --identity-tab-color: ${c.cyan} !important; --identity-icon-color: ${c.cyan} !important; }
    .identity-color-green { --identity-tab-color: ${c.green} !important; --identity-icon-color: ${c.green} !important; }
    .identity-color-yellow { --identity-tab-color: ${c.yellow} !important; --identity-icon-color: ${c.yellow} !important; }
    .identity-color-orange { --identity-tab-color: ${c.orange} !important; --identity-icon-color: ${c.orange} !important; }
    .identity-color-red { --identity-tab-color: ${c.red} !important; --identity-icon-color: ${c.red} !important; }
    .identity-color-pink { --identity-tab-color: ${c.red} !important; --identity-icon-color: ${c.red} !important; }
    .identity-color-purple { --identity-tab-color: ${c.purple} !important; --identity-icon-color: ${c.purple} !important; }
  '';
in
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    darwinDefaultsId = "app.zen-browser.zen";
    profiles.Default = {
      isDefault = true;
      userChrome = userChrome;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };

    policies = {
      Preferences = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = {
          Value = true;
          Status = "locked";
        };
      };
      DisableAppUpdate = true;
      DontCheckDefaultBrowser = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxScreenshots = true; # Using CleanShot instead
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      AutofillCreditCardEnabled = false;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        SkipOnboarding = true;
      };

      # Privacy
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };

      # DNS over HTTPS
      DNSOverHTTPS = {
        Enabled = true;
        Locked = true;
        ProviderURL = "https://dns.quad9.net/dns-query";
      };

      ExtensionSettings = {
        # 1Password
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/1password-x-password-manager/latest.xpi";
        };
        # uBlock Origin
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        # Dark Reader
        "addon@darkreader.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
        };
        # Privacy Badger
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
        };
        # ClearURLs
        "{74145f27-f039-47ce-a470-a662b129930a}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
        };
        # SponsorBlock
        "sponsorBlocker@ajay.app" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
        };
      };
    };
  };

  # Don't let home-manager manage profiles.ini - Zen needs to write to it
  home.file."Library/Application Support/Zen/profiles.ini".enable = false;
}
