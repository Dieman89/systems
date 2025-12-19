_:

let
  theme = import ../shared/theme.nix;
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;
      command_timeout = 1000;

      format = "$username$hostname$directory$git_branch$git_status$git_metrics$package$aws$kubernetes$cmd_duration$jobs\n$character";
      right_format = "\${custom.weather}$battery$time";

      username = {
        style_user = "bold ${theme.colors.orange}";
        style_root = "bold ${theme.colors.red}";
        format = "[$user]($style) in ";
        show_always = false;
      };

      hostname = {
        style = "bold ${theme.colors.orange}";
        format = "[$hostname]($style) ";
        ssh_only = true;
      };

      directory = {
        style = "bold ${theme.colors.cyan}";
        format = "[$path]($style) ";
        truncation_length = 3;
        truncation_symbol = "";
      };

      git_branch = {
        symbol = "";
        style = theme.colors.purple;
        format = "on [$symbol$branch]($style) ";
      };

      git_status = {
        style = theme.colors.red;
        format = "([$all_status$ahead_behind]($style) )";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
        untracked = "?";
        stashed = "*";
        modified = "!";
        staged = "+";
        deleted = "✘";
      };

      git_metrics = {
        disabled = false;
        added_style = theme.colors.green;
        deleted_style = theme.colors.red;
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
      };

      package = {
        symbol = "";
        style = theme.colors.orange;
        format = "is [$symbol$version]($style) ";
      };

      aws = {
        symbol = "";
        style = theme.colors.yellow;
        format = "on [$symbol$profile]($style) ";
        region_aliases = {
          eu-west-1 = "eu";
          us-east-1 = "us";
        };
      };

      kubernetes = {
        symbol = "☸";
        style = theme.colors.yellow;
        format = "on [$symbol$context]($style) ";
        disabled = false;
      };

      cmd_duration = {
        min_time = 2000;
        style = theme.colors.yellow;
        format = "took [$duration]($style) ";
      };

      time = {
        disabled = false;
        style = theme.colors.comment;
        format = "[$time]($style)";
        time_format = "%H:%M";
      };

      battery = {
        disabled = false;
        format = "[$symbol$percentage]($style) ";
        display = [
          { threshold = 30; style = theme.colors.red; discharging_symbol = "󰁺 "; }
          { threshold = 60; style = theme.colors.yellow; discharging_symbol = "󰁾 "; }
          { threshold = 100; style = theme.colors.green; discharging_symbol = "󰁹 "; }
        ];
      };

      jobs = {
        symbol = "✦";
        style = theme.colors.purple;
        format = "[$symbol$number]($style) ";
        number_threshold = 1;
        symbol_threshold = 1;
      };

      character = {
        success_symbol = "[❯](bold ${theme.colors.green}) ";
        error_symbol = "[❯](bold ${theme.colors.red}) ";
        vimcmd_symbol = "[❮](bold ${theme.colors.purple}) ";
        vimcmd_replace_symbol = "[❮](bold ${theme.colors.red}) ";
        vimcmd_visual_symbol = "[❮](bold ${theme.colors.yellow}) ";
      };

      custom.weather = {
        command = "cat ~/.cache/weather 2>/dev/null || echo '?'";
        when = "test -f ~/.cache/weather";
        format = "[$output]($style) ";
        style = theme.colors.cyan;
      };
    };
  };
}
