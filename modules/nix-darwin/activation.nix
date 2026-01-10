{ pkgs, username, ... }:

let
  homeDir = "/Users/${username}";
  asUser = cmd: "sudo -u ${username} ${cmd}";
  plistBuddy = "/usr/libexec/PlistBuddy";
  hotKeysPlist = "${homeDir}/Library/Preferences/com.apple.symbolichotkeys.plist";
  wallpaper = pkgs.runCommand "wallpaper" { } ''
    mkdir -p $out
    cp ${../../assets/wallpaper.png} $out/wallpaper.png
  '';
  disableHotKey = id: ''
    ${asUser plistBuddy} -c "Delete :AppleSymbolicHotKeys:${id}" ${hotKeysPlist} 2>/dev/null || true
    ${asUser plistBuddy} -c "Add :AppleSymbolicHotKeys:${id}:enabled bool false" ${hotKeysPlist}
  '';
  setDefaultApp = app: scheme: ''
    NSWorkspace.shared.setDefaultApplication(at: URL(fileURLWithPath: "/Applications/${app}.app"), toOpenURLsWithScheme: "${scheme}")
  '';
  osascript = script: "${asUser "osascript"} -e '${script}' ";

  keyboardShortcuts = ''
    # Disable Spotlight shortcut (Cmd+Space) for Raycast
    ${disableHotKey "64"}

    # Disable screenshot shortcuts for CleanShot
    # IDs: Cmd+Shift+3, Cmd+Ctrl+Shift+3, Cmd+Shift+4, Cmd+Ctrl+Shift+4, Cmd+Shift+5, Cmd+Shift+6, Cmd+Ctrl+Shift+6
    ${builtins.concatStringsSep "\n" (
      map disableHotKey [
        "28"
        "29"
        "30"
        "31"
        "184"
        "181"
        "182"
      ]
    )}
  '';

  defaultApps = ''
    # Default browser (ignore error if zen not installed yet)
    ${asUser "${pkgs.defaultbrowser}/bin/defaultbrowser zen"} 2>/dev/null || true

    # Default apps for URL schemes
    ${asUser "swift"} - <<'SWIFT'
    import AppKit
    ${setDefaultApp "Proton Mail" "mailto"}
    ${setDefaultApp "Fantastical" "webcal"}
    SWIFT
  '';

  desktopSettings = ''
    # Desktop icons: 36px with 12pt text
    ${osascript "tell application \"Finder\" to set icon size of icon view options of window of desktop to 36"}
    ${osascript "tell application \"Finder\" to set text size of icon view options of window of desktop to 12"}

    # Set wallpaper
    ${osascript "tell application \"System Events\" to tell every desktop to set picture to \"${wallpaper}/wallpaper.png\""}
  '';

  services = ''
    ${asUser "/opt/homebrew/bin/brew services restart borders"} 2>/dev/null || true
  '';

  # Zen Browser setup (Homebrew version)
  # Write policies to app bundle and re-sign (system-wide policies not supported)
  zenSetup = ''
        # Policies in app bundle
        mkdir -p "/Applications/Zen.app/Contents/Resources/distribution"
        cat > "/Applications/Zen.app/Contents/Resources/distribution/policies.json" << 'EOF'
    {
      "policies": {
        "DontCheckDefaultBrowser": true,
        "DisableFeedbackCommands": true,
        "DisableFirefoxStudies": true,
        "DisablePocket": true,
        "DisableTelemetry": true,
        "NoDefaultBookmarks": true,
        "OfferToSaveLogins": false,
        "PasswordManagerEnabled": false,
        "DNSOverHTTPS": {
          "Enabled": true,
          "Locked": true,
          "ProviderURL": "https://dns.quad9.net/dns-query"
        },
        "ExtensionSettings": {
          "uBlock0@raymondhill.net": {
            "installation_mode": "force_installed",
            "install_url": "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
          },
          "sponsorBlocker@ajay.app": {
            "installation_mode": "force_installed",
            "install_url": "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi"
          },
          "{74145f27-f039-47ce-a470-a662b129930a}": {
            "installation_mode": "force_installed",
            "install_url": "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi"
          },
          "jid1-MnnxcxisBPnSXQ@jetpack": {
            "installation_mode": "force_installed",
            "install_url": "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi"
          },
          "{930de1b4-9447-4927-9877-4f7cc369bc57}": {
            "installation_mode": "force_installed",
            "install_url": "https://addons.mozilla.org/firefox/downloads/latest/monokai-pro-filter-ristretto/latest.xpi"
          }
        }
      }
    }
    EOF

        # Re-sign app after modifying bundle (required for Gatekeeper)
        xattr -cr "/Applications/Zen.app" 2>/dev/null || true
        codesign --force --deep --sign - "/Applications/Zen.app" 2>/dev/null || true

        # Settings via user.js and userChrome.css in Zen profiles
        for profile in "${homeDir}/Library/Application Support/zen/Profiles"/*; do
          if [ -d "$profile" ]; then
            # User preferences
            cat > "$profile/user.js" << 'USERJS'
    // Privacy settings
    user_pref("privacy.resistFingerprinting", false);
    user_pref("layout.css.font-visibility.level", 3);
    user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
    // Disable Zen gradient theme
    user_pref("zen.theme.gradient", false);
    USERJS
            chown ${username}:staff "$profile/user.js" 2>/dev/null || true

            # Monokai Ristretto theme via userChrome.css
            mkdir -p "$profile/chrome"
            cat > "$profile/chrome/userChrome.css" << 'USERCSS'
    /* Monokai Ristretto Theme for Zen Browser */
    :root {
      --zen-colors-primary: #5b5353 !important;
      --zen-primary-color: #f38d70 !important;
      --zen-colors-secondary: #5b5353 !important;
      --zen-colors-tertiary: #403838 !important;
      --zen-colors-border: #f38d70 !important;
      --toolbarbutton-icon-fill: #f38d70 !important;
      --lwt-text-color: #fff1f3 !important;
      --toolbar-field-color: #fff1f3 !important;
      --tab-selected-textcolor: #fff1f3 !important;
      --toolbar-field-focus-color: #fff1f3 !important;
      --newtab-text-primary-color: #fff1f3 !important;
      --arrowpanel-color: #fff1f3 !important;
      --arrowpanel-background: #2c2525 !important;
      --sidebar-text-color: #fff1f3 !important;
      --lwt-sidebar-text-color: #fff1f3 !important;
      --lwt-sidebar-background-color: #2c2525 !important;
      --toolbar-bgcolor: #2c2525 !important;
      --newtab-background-color: #2c2525 !important;
      --zen-themed-toolbar-bg: #2c2525 !important;
      --zen-main-browser-background: #2c2525 !important;
      --tab-selected-bgcolor: transparent !important;
      --autocomplete-popup-highlight-background: #403838 !important;
      --toolbar-field-background-color: #2c2525 !important;
      --toolbar-field-focus-background-color: #2c2525 !important;
    }
    /* ALL text white */
    #sidebar-box, .sidebar-panel, .tab-label, .tab-text,
    #zen-workspaces-button, #zen-workspaces-button *,
    .zen-workspace-name, [class*="workspace"] { color: #fff1f3 !important; }
    /* URL bar */
    #urlbar-input, .urlbar-input { color: #fff1f3 !important; }
    #urlbar-input::selection, .urlbar-input::selection {
      background-color: #f38d70 !important; color: #2c2525 !important;
    }
    /* URL bar background */
    .urlbar-background, #urlbar-background,
    #urlbar[focused] .urlbar-background,
    #urlbar .urlbar-input-container { background: #2c2525 !important; }
    /* URL bar dropdown */
    .urlbarView, #urlbar-results, .urlbarView-body-outer, .urlbarView-body-inner { background: #2c2525 !important; }
    .urlbarView-row .urlbarView-title { color: #fff1f3 !important; }
    .urlbarView-row .urlbarView-url { color: #f38d70 !important; }
    /* URL bar selected row */
    .urlbarView-row[selected] {
      background: #403838 !important; border: 2px solid #fd6883 !important;
      border-radius: 6px !important; margin: 2px 4px !important;
    }
    .urlbarView-row[selected] *, .urlbarView-row[selected] .urlbarView-title,
    .urlbarView-row[selected] .urlbarView-secondary { color: #fff1f3 !important; }
    .urlbarView-row[selected] .urlbarView-url { color: #f38d70 !important; }
    /* TABS */
    .tabbrowser-tab[selected] .tab-background,
    .tabbrowser-tab[visuallyselected] .tab-background {
      background: transparent !important; border: 2px solid #fd6883 !important; border-radius: 6px !important;
    }
    .tabbrowser-tab[selected] .tab-label,
    .tabbrowser-tab[visuallyselected] .tab-label { color: #fff1f3 !important; }
    /* Backgrounds */
    #zen-main-app-wrapper, #zen-appcontent-wrapper, #zen-sidebar-splitter {
      appearance: unset !important; background: #2c2525 !important;
    }
    .sidebar-placesTree, #zen-workspaces-button, #TabsToolbar, hbox#titlebar,
    #zen-appcontent-navbar-container { background-color: #2c2525 !important; }
    /* Separator line */
    hr, toolbarseparator { border-color: #5b5353 !important; background: transparent !important; }
    /* Container colors */
    .identity-color-blue { --identity-tab-color: #85dacc !important; }
    .identity-color-green { --identity-tab-color: #adda78 !important; }
    .identity-color-yellow { --identity-tab-color: #f9cc6c !important; }
    .identity-color-orange { --identity-tab-color: #f38d70 !important; }
    .identity-color-red { --identity-tab-color: #fd6883 !important; }
    .identity-color-purple { --identity-tab-color: #a8a9eb !important; }
    /* Remove gray borders from search dropdown */
    .urlbarView, #urlbar-results, .urlbarView-body-outer, .urlbarView-body-inner,
    #PopupAutoComplete, panel[type="autocomplete"], #urlbar-container, #urlbar, .urlbar-input-box {
      border: none !important; box-shadow: none !important; outline: none !important;
    }
    /* New Tab page styling */
    #newtab-container, .contentWrapper, body[class*="newtab"], #root, .outer-wrapper { background-color: #2c2525 !important; }
    /* Browser content area */
    browser[type="content"], #browser, #tabbrowser-tabpanels, .browserContainer { background-color: #2c2525 !important; }
    /* New tab text */
    .title, .search-wrapper input, .top-site-outer .title { color: #fff1f3 !important; }
    /* Non-selected tabs transparent */
    .tabbrowser-tab:not([selected]) .tab-background { background: transparent !important; }
    /* New Tab button */
    #tabs-newtab-button, .tabs-newtab-button {
      background-color: #4a3f3f !important; border-radius: 6px !important;
    }
    #tabs-newtab-button:hover, .tabs-newtab-button:hover { background-color: #5b4e4e !important; }
    USERCSS
            chown ${username}:staff "$profile/chrome/userChrome.css" 2>/dev/null || true

            # userContent.css for new tab page
            cat > "$profile/chrome/userContent.css" << 'USERCONTENT'
    /* Monokai Ristretto - New Tab Page */
    @-moz-document url("about:newtab"), url("about:home"), url("about:blank") {
      body, html, #root, .outer-wrapper { background-color: #2c2525 !important; }
      * { color: #fff1f3 !important; }
      .search-wrapper input, .search-handoff-button {
        background-color: #403838 !important; color: #fff1f3 !important; border-color: #5b5353 !important;
      }
      .top-site-outer .title { color: #fff1f3 !important; }
      .icon { background-color: #403838 !important; }
    }
    USERCONTENT
            chown ${username}:staff "$profile/chrome/userContent.css" 2>/dev/null || true
          fi
        done
  '';

  applyAndCleanup = ''
    # Refresh preferences
    killall cfprefsd 2>/dev/null || true
    killall Finder 2>/dev/null || true
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

    # Fix repo ownership (can become root-owned after sudo darwin-rebuild)
    chown -R ${username}:admin ${homeDir}/systems 2>/dev/null || true
  '';

in
{
  environment.systemPackages = [ pkgs.defaultbrowser ];

  system.activationScripts.extraActivation.text = ''
    ${keyboardShortcuts}
    ${defaultApps}
    ${desktopSettings}
    ${services}
    ${zenSetup}
    ${applyAndCleanup}
  '';
}
