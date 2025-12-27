# All available themes with their color palettes
# Usage: themes.${themeName} where themeName is one of:
#   - monokai-ristretto (default)
#   - catppuccin-latte (light)
#   - catppuccin-frappe
#   - catppuccin-macchiato
#   - catppuccin-mocha
{
  monokai-ristretto = {
    name = "Monokai Ristretto";
    isDark = true;
    colors = {
      bg = "#2c2525";
      bgLighter = "#403838";
      fg = "#fff1f3";
      selection = "#5b5353";
      comment = "#72696a";
      red = "#fd6883";
      green = "#adda78";
      yellow = "#f9cc6c";
      orange = "#f38d70";
      purple = "#a8a9eb";
      cyan = "#85dacc";
      cursor = "#c3b7b8";
      cursorText = "#fff7f8";
    };
    diff = {
      minus = "#3d2a2d";
      minusEmph = "#5c3035";
      plus = "#2d3a2e";
      plusEmph = "#3d5040";
    };
    apps = {
      vscode = {
        theme = "Monokai Pro (Filter Ristretto)";
        iconTheme = "Monokai Pro (Filter Ristretto) Icons";
        extension = {
          name = "theme-monokai-pro-vscode";
          publisher = "monokai";
          version = "2.0.11";
          sha256 = "03sbsi0m8n5w6vwwshafllm4iy0wapf0qnyym2m50w3cynrl5kmw";
        };
      };
      zed = {
        theme = "Zedokai (Filter Ristretto)";
        lightTheme = "Zedokai (Filter Machine)";
      };
      bat = "Monokai Extended";
      atuin = {
        name = "monokai-ristretto";
        colors = {
          AlertInfo = "#adda78";
          AlertWarn = "#f38d70";
          AlertError = "#fd6883";
          Annotation = "#a8a9eb";
          Base = "#fff1f3";
          Guidance = "#72696a";
          Important = "#fd6883";
          Title = "#a8a9eb";
        };
      };
      ghostty = "monokai-pro-ristretto";
      fzf = "--color=bg+:#403838,bg:#2c2525,spinner:#c3b7b8,hl:#fd6883 --color=fg:#fff1f3,header:#fd6883,info:#a8a9eb,pointer:#c3b7b8 --color=marker:#85dacc,fg+:#fff1f3,prompt:#a8a9eb,hl+:#fd6883 --color=selected-bg:#5b5353 --color=border:#72696a,label:#fff1f3";
      delta = {
        dark = true;
        syntaxTheme = "Monokai Extended";
        minusStyle = "syntax \"#3d2a2d\"";
        minusEmphStyle = "bold syntax \"#5c3035\"";
        plusStyle = "syntax \"#2d3a2e\"";
        plusEmphStyle = "bold syntax \"#3d5040\"";
      };
    };
  };

  catppuccin-latte = {
    name = "Catppuccin Latte";
    isDark = false;
    colors = {
      bg = "#eff1f5";
      bgLighter = "#e6e9ef";
      fg = "#4c4f69";
      selection = "#acb0be";
      comment = "#9ca0b0";
      red = "#d20f39";
      green = "#40a02b";
      yellow = "#df8e1d";
      orange = "#fe640b";
      purple = "#8839ef";
      cyan = "#179299";
      cursor = "#dc8a78";
      cursorText = "#eff1f5";
    };
    diff = {
      minus = "#f5e0dc";
      minusEmph = "#eba0ac";
      plus = "#d5e8d4";
      plusEmph = "#a6e3a1";
    };
    apps = {
      vscode = {
        theme = "Catppuccin Latte";
        iconTheme = "catppuccin-latte";
        extension = {
          name = "catppuccin-vsc";
          publisher = "Catppuccin";
          version = "3.18.1";
          sha256 = "16hxf4ka2cj46vlcz8xl0vpf21d1jxkrydmaaq1jhi8v12fpk61a";
        };
        iconExtension = {
          name = "catppuccin-vsc-icons";
          publisher = "Catppuccin";
          version = "1.26.0";
          sha256 = "0ggz024rf69awnkx66fjyc2bpk48dj3bxrdn1q28vfm8s0v62mjp";
        };
      };
      zed = {
        theme = "Catppuccin Latte";
        lightTheme = "Catppuccin Latte";
      };
      bat = "Catppuccin Latte";
      atuin = {
        name = "catppuccin-latte-mauve";
        colors = {
          AlertInfo = "#40a02b";
          AlertWarn = "#fe640b";
          AlertError = "#d20f39";
          Annotation = "#8839ef";
          Base = "#4c4f69";
          Guidance = "#7c7f93";
          Important = "#d20f39";
          Title = "#8839ef";
        };
      };
      ghostty = "catppuccin-latte";
      fzf = "--color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 --color=selected-bg:#BCC0CC --color=border:#9CA0B0,label:#4C4F69";
      delta = {
        dark = false;
        syntaxTheme = "Catppuccin Latte";
        minusStyle = "syntax \"#e9c4cf\"";
        minusEmphStyle = "bold syntax \"#e5a2b3\"";
        plusStyle = "syntax \"#cce1cd\"";
        plusEmphStyle = "bold syntax \"#b2d5ae\"";
      };
    };
  };

  catppuccin-frappe = {
    name = "Catppuccin Frappé";
    isDark = true;
    colors = {
      bg = "#303446";
      bgLighter = "#414559";
      fg = "#c6d0f5";
      selection = "#626880";
      comment = "#737994";
      red = "#e78284";
      green = "#a6d189";
      yellow = "#e5c890";
      orange = "#ef9f76";
      purple = "#ca9ee6";
      cyan = "#81c8be";
      cursor = "#f2d5cf";
      cursorText = "#303446";
    };
    diff = {
      minus = "#45394a";
      minusEmph = "#5c3d4f";
      plus = "#384535";
      plusEmph = "#4a5e46";
    };
    apps = {
      vscode = {
        theme = "Catppuccin Frappé";
        iconTheme = "catppuccin-frappe";
        extension = {
          name = "catppuccin-vsc";
          publisher = "Catppuccin";
          version = "3.18.1";
          sha256 = "16hxf4ka2cj46vlcz8xl0vpf21d1jxkrydmaaq1jhi8v12fpk61a";
        };
        iconExtension = {
          name = "catppuccin-vsc-icons";
          publisher = "Catppuccin";
          version = "1.26.0";
          sha256 = "0ggz024rf69awnkx66fjyc2bpk48dj3bxrdn1q28vfm8s0v62mjp";
        };
      };
      zed = {
        theme = "Catppuccin Frappé";
        lightTheme = "Catppuccin Frappé";
      };
      bat = "Catppuccin Frappe";
      atuin = {
        name = "catppuccin-frappe-mauve";
        colors = {
          AlertInfo = "#a6d189";
          AlertWarn = "#ef9f76";
          AlertError = "#e78284";
          Annotation = "#ca9ee6";
          Base = "#c6d0f5";
          Guidance = "#949cbb";
          Important = "#e78284";
          Title = "#ca9ee6";
        };
      };
      ghostty = "catppuccin-frappe";
      fzf = "--color=bg+:#414559,bg:#303446,spinner:#F2D5CF,hl:#E78284 --color=fg:#C6D0F5,header:#E78284,info:#CA9EE6,pointer:#F2D5CF --color=marker:#BABBF1,fg+:#C6D0F5,prompt:#CA9EE6,hl+:#E78284 --color=selected-bg:#51576D --color=border:#737994,label:#C6D0F5";
      delta = {
        dark = true;
        syntaxTheme = "Catppuccin Frappe";
        minusStyle = "syntax \"#544452\"";
        minusEmphStyle = "bold syntax \"#704f5c\"";
        plusStyle = "syntax \"#475453\"";
        plusEmphStyle = "bold syntax \"#596b5e\"";
      };
    };
  };

  catppuccin-macchiato = {
    name = "Catppuccin Macchiato";
    isDark = true;
    colors = {
      bg = "#24273a";
      bgLighter = "#363a4f";
      fg = "#cad3f5";
      selection = "#5b6078";
      comment = "#6e738d";
      red = "#ed8796";
      green = "#a6da95";
      yellow = "#eed49f";
      orange = "#f5a97f";
      purple = "#c6a0f6";
      cyan = "#8bd5ca";
      cursor = "#f4dbd6";
      cursorText = "#24273a";
    };
    diff = {
      minus = "#3d2e3f";
      minusEmph = "#553a4a";
      plus = "#2e3d30";
      plusEmph = "#3f5541";
    };
    apps = {
      vscode = {
        theme = "Catppuccin Macchiato";
        iconTheme = "catppuccin-macchiato";
        extension = {
          name = "catppuccin-vsc";
          publisher = "Catppuccin";
          version = "3.18.1";
          sha256 = "16hxf4ka2cj46vlcz8xl0vpf21d1jxkrydmaaq1jhi8v12fpk61a";
        };
        iconExtension = {
          name = "catppuccin-vsc-icons";
          publisher = "Catppuccin";
          version = "1.26.0";
          sha256 = "0ggz024rf69awnkx66fjyc2bpk48dj3bxrdn1q28vfm8s0v62mjp";
        };
      };
      zed = {
        theme = "Catppuccin Macchiato";
        lightTheme = "Catppuccin Macchiato";
      };
      bat = "Catppuccin Macchiato";
      atuin = {
        name = "catppuccin-macchiato-mauve";
        colors = {
          AlertInfo = "#a6da95";
          AlertWarn = "#f5a97f";
          AlertError = "#ed8796";
          Annotation = "#c6a0f6";
          Base = "#cad3f5";
          Guidance = "#939ab7";
          Important = "#ed8796";
          Title = "#c6a0f6";
        };
      };
      ghostty = "catppuccin-macchiato";
      fzf = "--color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 --color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 --color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 --color=selected-bg:#494D64 --color=border:#6E738D,label:#CAD3F5";
      delta = {
        dark = true;
        syntaxTheme = "Catppuccin Macchiato";
        minusStyle = "syntax \"#4c3a4c\"";
        minusEmphStyle = "bold syntax \"#6a485a\"";
        plusStyle = "syntax \"#3e4b4c\"";
        plusEmphStyle = "bold syntax \"#51655a\"";
      };
    };
  };

  catppuccin-mocha = {
    name = "Catppuccin Mocha";
    isDark = true;
    colors = {
      bg = "#1e1e2e";
      bgLighter = "#313244";
      fg = "#cdd6f4";
      selection = "#585b70";
      comment = "#6c7086";
      red = "#f38ba8";
      green = "#a6e3a1";
      yellow = "#f9e2af";
      orange = "#fab387";
      purple = "#cba6f7";
      cyan = "#94e2d5";
      cursor = "#f5e0dc";
      cursorText = "#1e1e2e";
    };
    diff = {
      minus = "#3b2834";
      minusEmph = "#53344a";
      plus = "#263329";
      plusEmph = "#374b3a";
    };
    apps = {
      vscode = {
        theme = "Catppuccin Mocha";
        iconTheme = "catppuccin-mocha";
        extension = {
          name = "catppuccin-vsc";
          publisher = "Catppuccin";
          version = "3.18.1";
          sha256 = "16hxf4ka2cj46vlcz8xl0vpf21d1jxkrydmaaq1jhi8v12fpk61a";
        };
        iconExtension = {
          name = "catppuccin-vsc-icons";
          publisher = "Catppuccin";
          version = "1.26.0";
          sha256 = "0ggz024rf69awnkx66fjyc2bpk48dj3bxrdn1q28vfm8s0v62mjp";
        };
      };
      zed = {
        theme = "Catppuccin Mocha";
        lightTheme = "Catppuccin Mocha";
      };
      bat = "Catppuccin Mocha";
      atuin = {
        name = "catppuccin-mocha-mauve";
        colors = {
          AlertInfo = "#a6e3a1";
          AlertWarn = "#fab387";
          AlertError = "#f38ba8";
          Annotation = "#cba6f7";
          Base = "#cdd6f4";
          Guidance = "#9399b2";
          Important = "#f38ba8";
          Title = "#cba6f7";
        };
      };
      ghostty = "catppuccin-mocha";
      fzf = "--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 --color=selected-bg:#45475A --color=border:#6C7086,label:#CDD6F4";
      delta = {
        dark = true;
        syntaxTheme = "Catppuccin Mocha";
        minusStyle = "syntax \"#493447\"";
        minusEmphStyle = "bold syntax \"#694559\"";
        plusStyle = "syntax \"#394545\"";
        plusEmphStyle = "bold syntax \"#4e6356\"";
      };
    };
  };
}
