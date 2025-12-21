{ inputs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;

    # Required for macOS to set as default browser
    darwinDefaultsId = "app.zen-browser.zen";

    policies = {
      # App management
      DisableAppUpdate = true; # Managed by Nix
      DontCheckDefaultBrowser = true;

      # Disable built-in features we don't need
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFirefoxScreenshots = true; # Using CleanShot instead
      NoDefaultBookmarks = true;

      # Disable built-in password/autofill (using 1Password)
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      AutofillCreditCardEnabled = false;

      # Skip first run and update pages
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";

      # Disable extension recommendations and other messaging
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

      # Extensions to install (via policy instead of profile management)
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

    # No profile management - let Zen handle it
  };
}
