# Shared helper functions
{
  pkgs,
  lib ? null,
}:

{
  # Create an activation script that copies a config file to a destination
  # Removes symlinks first, then copies with 644 permissions
  mkConfigCopy =
    { destDir, srcFile }:
    assert lib != null;
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p "${destDir}"
      [ -L "${destDir}/settings.json" ] && rm "${destDir}/settings.json"
      cp ${srcFile} "${destDir}/settings.json"
      chmod 644 "${destDir}/settings.json"
    '';

  # Create a fake package for Homebrew-installed apps
  # This allows home-manager to manage config without installing the app via Nix
  mkFakePkg =
    name:
    let
      isVSCode = name == "vscode";
      isGhostty = name == "ghostty";
      buildScript =
        if isVSCode then
          ''
            mkdir -p $out/bin $out/lib/vscode
            echo '{"dataFolderName": ".vscode"}' > $out/lib/vscode/product.json
          ''
        else if isGhostty then
          ''
            mkdir -p $out/bin
            # Create a wrapper that calls Homebrew's ghostty
            cat > $out/bin/ghostty << 'EOF'
            #!/bin/sh
            exec /Applications/Ghostty.app/Contents/MacOS/ghostty "$@"
            EOF
            chmod +x $out/bin/ghostty
          ''
        else
          ''
            mkdir -p $out/bin
          '';
    in
    pkgs.runCommand name { } buildScript
    // {
      pname = name;
      version = "0.0.0";
      meta.mainProgram = if isVSCode then "code" else name;
    };
}
