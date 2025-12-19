{ pkgs, username, ... }:

{
  # System packages needed for activation scripts
  environment.systemPackages = with pkgs; [
    defaultbrowser
  ];

  # Activation scripts for default apps and system settings
  system.activationScripts.extraActivation.text = ''
    # Set Zen as default browser
    sudo -u ${username} ${pkgs.defaultbrowser}/bin/defaultbrowser zen

    # Disable Spotlight keyboard shortcut (Cmd+Space) so Raycast can use it
    sudo -u ${username} /usr/libexec/PlistBuddy \
      -c "Delete :AppleSymbolicHotKeys:64" \
      /Users/${username}/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true
    sudo -u ${username} /usr/libexec/PlistBuddy \
      -c "Add :AppleSymbolicHotKeys:64:enabled bool false" \
      /Users/${username}/Library/Preferences/com.apple.symbolichotkeys.plist

    # Disable screenshot shortcuts so CleanShot can use them
    # 28=Cmd+Shift+3, 29=Cmd+Ctrl+Shift+3, 30=Cmd+Shift+4, 31=Cmd+Ctrl+Shift+4
    # 184=Cmd+Shift+5, 181=Cmd+Shift+6, 182=Cmd+Ctrl+Shift+6
    for key in 28 29 30 31 184 181 182; do
      sudo -u ${username} /usr/libexec/PlistBuddy \
        -c "Delete :AppleSymbolicHotKeys:$key" \
        /Users/${username}/Library/Preferences/com.apple.symbolichotkeys.plist 2>/dev/null || true
      sudo -u ${username} /usr/libexec/PlistBuddy \
        -c "Add :AppleSymbolicHotKeys:$key:enabled bool false" \
        /Users/${username}/Library/Preferences/com.apple.symbolichotkeys.plist
    done

    # Set default apps using Swift/AppKit
    sudo -u ${username} swift - <<'SWIFT'
    import AppKit
    NSWorkspace.shared.setDefaultApplication(at: URL(fileURLWithPath: "/Applications/Proton Mail.app"), toOpenURLsWithScheme: "mailto")
    NSWorkspace.shared.setDefaultApplication(at: URL(fileURLWithPath: "/Applications/Fantastical.app"), toOpenURLsWithScheme: "webcal")
    SWIFT

    # Apply settings immediately
    killall cfprefsd 2>/dev/null || true
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

    # Restart borders (also starts if not running, registers for auto-start on login)
    sudo -u ${username} /opt/homebrew/bin/brew services restart borders 2>/dev/null || true
  '';
}
