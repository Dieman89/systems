_:

let
  theme = import ../shared/theme.nix;

  # Convert #RRGGBB to 0xffRRGGBB format (ff = full opacity)
  toArgb = hex: "0xff${builtins.substring 1 6 hex}";
in
{
  home.file.".config/borders/bordersrc" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh
      borders \
        active_color=${toArgb theme.colors.fg} \
        inactive_color=${toArgb theme.colors.comment} \
        width=6.0 \
        hidpi=on \
        style=round
    '';
  };
}
