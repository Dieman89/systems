{
  pkgs,
  lib,
  themeName,
  ...
}:

let
  theme = import ../shared/theme.nix themeName;

  settings = {
    auto_install_extensions = {
      zedokai = themeName == "monokai-ristretto";
      catppuccin = builtins.substring 0 10 themeName == "catppuccin";
      jetbrains-new-ui-icons = true;
      nix = true;
      html = true;
      dockerfile = true;
      docker-compose = true;
      terraform = true;
      yaml = true;
      toml = true;
      typst = true;
      helm = true;
      basedpyright = true;
      ruff = true;
      scala = true;
      elixir = true;
      markdown-oxide = true;
      git-firefly = true;
    };
    theme = {
      mode = if theme.isDark then "dark" else "light";
      dark = theme.apps.zed.theme;
      light = theme.apps.zed.lightTheme;
    };
    icon_theme = "JetBrains New UI Icons (Dark)";
    base_keymap = "VSCode";
    buffer_font_family = "Berkeley Mono";
    buffer_font_size = 13;
    ui_font_size = 14;
    terminal = {
      font_family = "FiraCode Nerd Font Mono";
      font_size = 12;
    };
    project_panel = {
      dock = "right";
      default_width = 240;
      file_icons = true;
      folder_icons = true;
      git_status = true;
      indent_size = 12;
      auto_reveal_entries = true;
      auto_fold_dirs = true;
      indent_guides = {
        show = "never";
      };
    };
    agent = {
      dock = "left";
    };
    outline_panel = {
      dock = "right";
    };
    minimap = {
      show = "never";
    };
    scrollbar = {
      show = "auto";
    };
    indent_guides = {
      enabled = true;
      coloring = "fixed";
    };
    inlay_hints = {
      enabled = true;
      show_type_hints = true;
      show_parameter_hints = true;
    };
    git = {
      inline_blame = {
        enabled = true;
      };
    };
    autosave = {
      after_delay = {
        milliseconds = 500;
      };
    };
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    languages = {
      Typst = {
        format_on_save = "on";
        formatter = {
          external = {
            command = "typstyle";
            arguments = [
              "-i"
              "{buffer_path}"
            ];
          };
        };
      };
      Elixir = {
        format_on_save = "on";
      };
      HEEX = {
        format_on_save = "on";
      };
    };
  };

  settingsJson = builtins.toJSON settings;
  settingsFile = pkgs.writeText "zed-settings.json" settingsJson;
in
{
  # Copy generated settings.json to Zed config directory
  home.activation.zedSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/.config/zed"
    [ -L "$HOME/.config/zed/settings.json" ] && rm "$HOME/.config/zed/settings.json"
    cp ${settingsFile} "$HOME/.config/zed/settings.json"
    chmod 644 "$HOME/.config/zed/settings.json"
  '';
}
