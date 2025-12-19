{ pkgs, username, ... }:

let
  homeDir = "/Users/${username}";
  hotKeysPlist = "${homeDir}/Library/Preferences/com.apple.symbolichotkeys.plist";
  asUser = cmd: "sudo -u ${username} ${cmd}";
  plistBuddy = "/usr/libexec/PlistBuddy";

  # Disable a macOS keyboard shortcut by its ID
  disableHotKey = id: ''
    ${asUser plistBuddy} -c "Delete :AppleSymbolicHotKeys:${id}" ${hotKeysPlist} 2>/dev/null || true
    ${asUser plistBuddy} -c "Add :AppleSymbolicHotKeys:${id}:enabled bool false" ${hotKeysPlist}
  '';

  # Set an app as default handler for a URL scheme
  setDefaultApp = app: scheme: ''
    NSWorkspace.shared.setDefaultApplication(at: URL(fileURLWithPath: "/Applications/${app}.app"), toOpenURLsWithScheme: "${scheme}")
  '';

  # Screenshot shortcut IDs: Cmd+Shift+3, Cmd+Ctrl+Shift+3, Cmd+Shift+4, Cmd+Ctrl+Shift+4, Cmd+Shift+5, Cmd+Shift+6, Cmd+Ctrl+Shift+6
  screenshotHotKeys = [
    "28"
    "29"
    "30"
    "31"
    "184"
    "181"
    "182"
  ];
in
{
  environment.systemPackages = [ pkgs.defaultbrowser ];

  system.activationScripts.extraActivation.text = ''
    # Default browser
    ${asUser "${pkgs.defaultbrowser}/bin/defaultbrowser zen"}

    # Disable Spotlight shortcut (Cmd+Space) for Raycast
    ${disableHotKey "64"}

    # Disable screenshot shortcuts for CleanShot
    ${builtins.concatStringsSep "\n" (map disableHotKey screenshotHotKeys)}

    # Default apps for URL schemes
    ${asUser "swift"} - <<'SWIFT'
    import AppKit
    ${setDefaultApp "Proton Mail" "mailto"}
    ${setDefaultApp "Fantastical" "webcal"}
    SWIFT

    # Apply settings
    killall cfprefsd 2>/dev/null || true
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

    # Start/restart window borders service
    ${asUser "/opt/homebrew/bin/brew services restart borders"} 2>/dev/null || true

    # Fix repo ownership (can become root-owned after sudo darwin-rebuild)
    chown -R ${username}:admin ${homeDir}/systems 2>/dev/null || true
  '';
}
