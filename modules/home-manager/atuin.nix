{ themeName, ... }:

let
  theme = import ../shared/theme.nix themeName;
  atuinTheme = theme.apps.atuin;

  atuinThemeToml = ''
    [theme]
    name = "${atuinTheme.name}"

    [colors]
    AlertInfo = "${atuinTheme.colors.AlertInfo}"
    AlertWarn = "${atuinTheme.colors.AlertWarn}"
    AlertError = "${atuinTheme.colors.AlertError}"
    Annotation = "${atuinTheme.colors.Annotation}"
    Base = "${atuinTheme.colors.Base}"
    Guidance = "${atuinTheme.colors.Guidance}"
    Important = "${atuinTheme.colors.Important}"
    Title = "${atuinTheme.colors.Title}"
  '';
in
{
  xdg.configFile."atuin/themes/${atuinTheme.name}.toml".text = atuinThemeToml;

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      search_mode = "fuzzy";
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "directory";
      style = "compact";
      inline_height = 20;
      show_preview = true;
      show_help = true;
      max_preview_height = 6;
      exit_mode = "return-original";
      update_check = false;
      sync_frequency = "0";
      secrets_filter = true;
      store_failed = true;
      dialect = "uk";
      enter_accept = true;
      keymap_mode = "emacs";
      workspaces = true;
      history_filter = [
        "^export .*SECRET"
        "^export .*TOKEN"
        "^export .*PASSWORD"
        "^export .*KEY="
      ];
      theme.name = atuinTheme.name;
    };
  };
}
