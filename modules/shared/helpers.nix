# Shared helper functions
{ pkgs }:

{
  # Create a fake package for Homebrew-installed apps
  # This allows home-manager to manage config without installing the app via Nix
  mkFakePkg =
    name:
    let
      isVSCode = name == "vscode";
      buildScript =
        if isVSCode then
          ''
            mkdir -p $out/bin $out/lib/vscode
            echo '{"dataFolderName": ".vscode"}' > $out/lib/vscode/product.json
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
