_:

let
  theme = import ../shared/theme.nix;
  atuinTheme = ''
    [theme]
    name = "ristretto"

    [colors]
    Base = "${theme.colors.fg}"
    Title = "${theme.colors.cyan}"
    Important = "${theme.colors.yellow}"
    Guidance = "${theme.colors.comment}"
    Annotation = "${theme.colors.comment}"
    AlertInfo = "${theme.colors.green}"
    AlertWarn = "${theme.colors.orange}"
    AlertError = "${theme.colors.red}"
  '';
in
{
  xdg.configFile."atuin/themes/ristretto.toml".text = atuinTheme;

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
      theme.name = "ristretto";
    };
  };
}
