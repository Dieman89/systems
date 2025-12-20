{ pkgs, username, ... }:

let
  homeDir = "/Users/${username}";
  asUser = cmd: "sudo -u ${username} ${cmd}";
  plistBuddy = "/usr/libexec/PlistBuddy";
  hotKeysPlist = "${homeDir}/Library/Preferences/com.apple.symbolichotkeys.plist";
  disableHotKey = id: ''
    ${asUser plistBuddy} -c "Delete :AppleSymbolicHotKeys:${id}" ${hotKeysPlist} 2>/dev/null || true
    ${asUser plistBuddy} -c "Add :AppleSymbolicHotKeys:${id}:enabled bool false" ${hotKeysPlist}
  '';
  setDefaultApp = app: scheme: ''
    NSWorkspace.shared.setDefaultApplication(at: URL(fileURLWithPath: "/Applications/${app}.app"), toOpenURLsWithScheme: "${scheme}")
  '';
  osascript = script: ''${asUser "osascript"} -e '${script}' '';

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
    # Default browser
    ${asUser "${pkgs.defaultbrowser}/bin/defaultbrowser zen"}

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
  '';

  services = ''
    ${asUser "/opt/homebrew/bin/brew services restart borders"} 2>/dev/null || true
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
    ${applyAndCleanup}
  '';
}
