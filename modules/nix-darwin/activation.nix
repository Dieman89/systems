{ config, pkgs, username, ... }:

{
  # System packages needed for activation scripts
  environment.systemPackages = with pkgs; [
    defaultbrowser
  ];

  # Activation scripts for default apps and system settings
  system.activationScripts.extraActivation.text = ''
    # Set Arc as default browser
    sudo -u ${username} ${pkgs.defaultbrowser}/bin/defaultbrowser browser

    # Disable Spotlight keyboard shortcut (Cmd+Space) so Raycast can use it
    sudo -u ${username} /usr/libexec/PlistBuddy \
      -c "Delete :AppleSymbolicHotKeys:64" \
      /Users/${username}/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true
    sudo -u ${username} /usr/libexec/PlistBuddy \
      -c "Add :AppleSymbolicHotKeys:64:enabled bool false" \
      /Users/${username}/Library/Preferences/com.apple.symbolichotkeys.plist

    # Set default apps using Swift/AppKit
    sudo -u ${username} swift - <<'SWIFT'
    import AppKit
    NSWorkspace.shared.setDefaultApplication(at: URL(fileURLWithPath: "/Applications/Proton Mail.app"), toOpenURLsWithScheme: "mailto")
    NSWorkspace.shared.setDefaultApplication(at: URL(fileURLWithPath: "/Applications/Fantastical.app"), toOpenURLsWithScheme: "webcal")
    SWIFT

    # Apply settings immediately
    killall cfprefsd 2>/dev/null || true
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
}
