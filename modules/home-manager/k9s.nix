{ pkgs, themeName, ... }:

let
  theme = import ../shared/theme.nix themeName;
  c = theme.colors;

  # Additional colors derived from theme
  bgDarker = if theme.isDark then c.bg else c.bgLighter;
  bgLighter = if theme.isDark then c.bgLighter else c.bg;
  k9sSkin = ''
    k9s:
      body:
        fgColor: '${c.fg}'
        bgColor: '${c.bg}'
        logoColor: '${c.purple}'
      prompt:
        fgColor: '${c.fg}'
        bgColor: '${bgDarker}'
        suggestColor: '${c.cyan}'
      help:
        fgColor: '${c.fg}'
        bgColor: '${c.bg}'
        sectionColor: '${c.green}'
        keyColor: '${c.cyan}'
        numKeyColor: '${c.red}'
      frame:
        title:
          fgColor: '${c.cyan}'
          bgColor: '${c.bg}'
          highlightColor: '${c.purple}'
          counterColor: '${c.yellow}'
          filterColor: '${c.green}'
        border:
          fgColor: '${c.purple}'
          focusColor: '${c.cyan}'
        menu:
          fgColor: '${c.fg}'
          keyColor: '${c.cyan}'
          numKeyColor: '${c.red}'
        crumbs:
          fgColor: '${c.bg}'
          bgColor: '${c.red}'
          activeColor: '${c.cursor}'
        status:
          newColor: '${c.cyan}'
          modifyColor: '${c.purple}'
          addColor: '${c.green}'
          pendingColor: '${c.orange}'
          errorColor: '${c.red}'
          highlightColor: '${c.cyan}'
          killColor: '${c.purple}'
          completedColor: '${c.comment}'
      info:
        fgColor: '${c.orange}'
        sectionColor: '${c.fg}'
      views:
        table:
          fgColor: '${c.fg}'
          bgColor: '${c.bg}'
          cursorFgColor: '${c.bgLighter}'
          cursorBgColor: '${c.selection}'
          markColor: '${c.cursor}'
          header:
            fgColor: '${c.yellow}'
            bgColor: '${c.bg}'
            sorterColor: '${c.cyan}'
        xray:
          fgColor: '${c.fg}'
          bgColor: '${c.bg}'
          cursorColor: '${c.selection}'
          cursorTextColor: '${c.bg}'
          graphicColor: '${c.purple}'
        charts:
          bgColor: '${c.bg}'
          chartBgColor: '${c.bg}'
          dialBgColor: '${c.bg}'
          defaultDialColors:
            - '${c.green}'
            - '${c.red}'
          defaultChartColors:
            - '${c.green}'
            - '${c.red}'
          resourceColors:
            cpu:
              - '${c.purple}'
              - '${c.cyan}'
            mem:
              - '${c.yellow}'
              - '${c.orange}'
        yaml:
          keyColor: '${c.cyan}'
          valueColor: '${c.fg}'
          colonColor: '${c.comment}'
        logs:
          fgColor: '${c.fg}'
          bgColor: '${c.bg}'
          indicator:
            fgColor: '${c.purple}'
            bgColor: '${c.bg}'
            toggleOnColor: '${c.green}'
            toggleOffColor: '${c.comment}'
      dialog:
        fgColor: '${c.yellow}'
        bgColor: '${c.comment}'
        buttonFgColor: '${c.bg}'
        buttonBgColor: '${c.selection}'
        buttonFocusFgColor: '${c.bg}'
        buttonFocusBgColor: '${c.purple}'
        labelFgColor: '${c.cursor}'
        fieldFgColor: '${c.fg}'
  '';
in
{
  home.file."Library/Application Support/k9s/skins/${themeName}.yaml".text = k9sSkin;

  programs.k9s = {
    enable = true;
    settings.k9s = {
      ui.skin = themeName;
    };
  };
}
