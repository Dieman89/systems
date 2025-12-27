{ themeName, ... }:

let
  theme = import ../shared/theme.nix themeName;
  c = theme.colors;

  btopTheme = ''
    # Main background, empty for terminal default, need to be empty if you want transparent background
    theme[main_bg]="${c.bg}"

    # Main text color
    theme[main_fg]="${c.fg}"

    # Title color for boxes
    theme[title]="${c.fg}"

    # Highlight color for keyboard shortcuts
    theme[hi_fg]="${c.cyan}"

    # Background color of selected item in processes box
    theme[selected_bg]="${c.selection}"

    # Foreground color of selected item in processes box
    theme[selected_fg]="${c.cyan}"

    # Color of inactive/disabled text
    theme[inactive_fg]="${c.comment}"

    # Color of text appearing on top of graphs
    theme[graph_text]="${c.cursor}"

    # Background color of the percentage meters
    theme[meter_bg]="${c.selection}"

    # Misc colors for processes box
    theme[proc_misc]="${c.cursor}"

    # Box outline colors
    theme[cpu_box]="${c.purple}"
    theme[mem_box]="${c.green}"
    theme[net_box]="${c.red}"
    theme[proc_box]="${c.cyan}"

    # Box divider line
    theme[div_line]="${c.comment}"

    # Temperature graph (Green -> Yellow -> Red)
    theme[temp_start]="${c.green}"
    theme[temp_mid]="${c.yellow}"
    theme[temp_end]="${c.red}"

    # CPU graph colors
    theme[cpu_start]="${c.cyan}"
    theme[cpu_mid]="${c.purple}"
    theme[cpu_end]="${c.purple}"

    # Mem/Disk free meter
    theme[free_start]="${c.purple}"
    theme[free_mid]="${c.purple}"
    theme[free_end]="${c.cyan}"

    # Mem/Disk cached meter
    theme[cached_start]="${c.cyan}"
    theme[cached_mid]="${c.cyan}"
    theme[cached_end]="${c.purple}"

    # Mem/Disk available meter (Peach -> Red)
    theme[available_start]="${c.orange}"
    theme[available_mid]="${c.red}"
    theme[available_end]="${c.red}"

    # Mem/Disk used meter (Green -> Cyan)
    theme[used_start]="${c.green}"
    theme[used_mid]="${c.cyan}"
    theme[used_end]="${c.cyan}"

    # Download graph colors
    theme[download_start]="${c.orange}"
    theme[download_mid]="${c.red}"
    theme[download_end]="${c.red}"

    # Upload graph colors
    theme[upload_start]="${c.green}"
    theme[upload_mid]="${c.cyan}"
    theme[upload_end]="${c.cyan}"

    # Process box gradient
    theme[process_start]="${c.cyan}"
    theme[process_mid]="${c.purple}"
    theme[process_end]="${c.purple}"
  '';
in
{
  xdg.configFile."btop/themes/${themeName}.theme".text = btopTheme;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = themeName;
      theme_background = true;
    };
  };
}
