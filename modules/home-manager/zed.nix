{ pkgs, lib, ... }:

let
  helpers = import ../shared/helpers.nix { inherit pkgs lib; };
in
{
  # Copy settings.json to Zed config directory
  home.activation.zedSettings = helpers.mkConfigCopy {
    destDir = "$HOME/.config/zed";
    srcFile = ../../config/zed/settings.json;
  };
}
