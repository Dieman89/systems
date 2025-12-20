{ lib, ... }:

{
  # Copy settings.json to Zed config directory
  home.activation.zedSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ZED_CONFIG_DIR="$HOME/.config/zed"
    mkdir -p "$ZED_CONFIG_DIR"
    [ -L "$ZED_CONFIG_DIR/settings.json" ] && rm "$ZED_CONFIG_DIR/settings.json"
    cp ${../../config/zed/settings.json} "$ZED_CONFIG_DIR/settings.json"
    chmod 644 "$ZED_CONFIG_DIR/settings.json"
  '';
}
