{
  pkgs,
  lib,
  themeName,
  ...
}:

let
  helpers = import ../shared/helpers.nix { inherit pkgs lib; };
  theme = import ../shared/theme.nix themeName;
  vscodeApp = theme.apps.vscode;
  allThemeExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "theme-monokai-pro-vscode";
      publisher = "monokai";
      version = "2.0.11";
      sha256 = "03sbsi0m8n5w6vwwshafllm4iy0wapf0qnyym2m50w3cynrl5kmw";
    }
    {
      name = "catppuccin-vsc";
      publisher = "Catppuccin";
      version = "3.18.1";
      sha256 = "16hxf4ka2cj46vlcz8xl0vpf21d1jxkrydmaaq1jhi8v12fpk61a";
    }
    {
      name = "catppuccin-vsc-icons";
      publisher = "Catppuccin";
      version = "1.26.0";
      sha256 = "0ggz024rf69awnkx66fjyc2bpk48dj3bxrdn1q28vfm8s0v62mjp";
    }
  ];

  settings = {
    # Workbench & Theme
    "workbench.colorTheme" = vscodeApp.theme;
    "workbench.iconTheme" = vscodeApp.iconTheme;
    "workbench.sideBar.location" = "right";
    "workbench.startupEditor" = "none";
    "workbench.colorCustomizations" = {
      "titleBar.activeBackground" = "#00000000";
      "titleBar.activeForeground" = "#00000000";
      "titleBar.background" = "#00000000";
      "titleBar.foreground" = "#00000000";
      "editorInfo.foreground" = "#00000000";
    };

    # Editor
    "editor.fontFamily" = "Berkeley Mono SemiCondensed";
    "editor.fontSize" = 13;
    "editor.codeLensFontFamily" = "Berkeley Mono";
    "editor.fontLigatures" =
      "'calt', 'liga', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09'";
    "editor.minimap.enabled" = false;
    "editor.formatOnPaste" = true;
    "editor.formatOnSave" = true;
    "editor.snippetSuggestions" = "top";
    "editor.accessibilitySupport" = "off";
    "editor.codeActionsOnSave" = {
      "source.fixAll.ruff" = "explicit";
    };
    "diffEditor.ignoreTrimWhitespace" = false;

    # Terminal
    "terminal.integrated.fontFamily" = "FiraCode Nerd Font Mono";
    "terminal.integrated.defaultProfile.osx" = "zsh (login)";
    "terminal.integrated.profiles.osx" = {
      "zsh (login)" = {
        path = "zsh";
        args = [ "-l" ];
      };
    };

    # Files
    "files.autoSave" = "afterDelay";
    "files.autoSaveDelay" = 500;
    "files.exclude" = {
      "**/*_templ.go" = true;
      "**/*_templ.txt" = true;
      "**/*.synctex.gz" = true;
      "**/.repomixignore" = true;
      "**/CLAUDE.md" = true;
      "**/metals.sbt" = true;
      "**/plans" = true;
      ".bloop" = true;
      ".bsp" = true;
      ".claude" = true;
      ".metals" = true;
      ".vscode" = true;
      "project/project" = true;
      "project/target" = true;
    };
    "files.watcherExclude" = {
      "**/.ammonite" = true;
      "**/.bloop" = true;
      "**/.direnv/**" = true;
      "**/.git/objects/**" = true;
      "**/.git/subtree-cache/**" = true;
      "**/.metals" = true;
      "**/.venv/**" = true;
      "**/node_modules/**" = true;
    };

    # Explorer
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
    "explorer.confirmPasteNative" = false;

    # Search
    "search.exclude" = {
      "**/.bloop" = true;
      "**/.git/**" = true;
      "**/.metals" = true;
      "**/bower_components" = true;
      "**/node_modules" = true;
      "**/project" = true;
      "**/target" = true;
      "**/venv/**" = true;
      "*_templ.txt" = true;
    };

    # Git
    "git.autofetch" = true;
    "git.confirmSync" = false;
    "git.ignoreRebaseWarning" = true;
    "git.openRepositoryInParentFolders" = "never";
    "git.replaceTagsWhenPull" = true;
    "git.blame.editorDecoration.enabled" = true;

    # GitHub Copilot
    "github.copilot.enable" = {
      "*" = true;
      markdown = false;
      plaintext = false;
      scminput = false;
    };
    "github.copilot.nextEditSuggestions.enabled" = true;

    # Security & Telemetry
    "security.workspace.trust.untrustedFiles" = "open";
    "telemetry.telemetryLevel" = "off";

    # Extensions
    "errorLens.enabled" = true;
    "gitlens.advanced.messages" = {
      suppressIntegrationDisconnectedTooManyFailedRequestsWarning = true;
    };
    "liveshare.guestApprovalRequired" = true;

    # Language: Nix
    "nix.enableLanguageServer" = true;
    "nix.serverPath" = "nil";
    "nix.serverSettings" = {
      nil = {
        formatting = {
          command = [ "nixfmt" ];
        };
      };
    };

    # Language: Python
    "ruff.configurationPreference" = "filesystemFirst";
    "ruff.fixAll" = true;
    "[python]" = {
      "editor.defaultFormatter" = "charliermarsh.ruff";
      "editor.formatOnType" = true;
    };

    # Language: Go
    "go.toolsManagement.autoUpdate" = true;

    # Language: Scala
    "metals.enableIndentOnPaste" = true;

    # Language: JavaScript/TypeScript
    "typescript.updateImportsOnFileMove.enabled" = "always";
    "[javascript]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };

    # Language: JSON
    "json.schemas" = [
      {
        fileMatch = [ "*-template.json" ];
        url = "https://s3.amazonaws.com/cfn-resource-specifications-us-east-1-prod/schemas/2.15.0/all-spec.json";
      }
    ];
    "[json][jsonc]" = {
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
    };

    # Language: YAML
    "yaml.maxItemsComputed" = 15000;
    "yaml.customTags" = [
      "!And"
      "!And sequence"
      "!If"
      "!If sequence"
      "!Not"
      "!Not sequence"
      "!Equals"
      "!Equals sequence"
      "!Or"
      "!Or sequence"
      "!FindInMap"
      "!FindInMap sequence"
      "!Base64"
      "!Join"
      "!Join sequence"
      "!Cidr"
      "!Ref"
      "!Sub"
      "!Sub sequence"
      "!GetAtt"
      "!GetAZs"
      "!ImportValue"
      "!ImportValue sequence"
      "!Select"
      "!Select sequence"
      "!Split"
      "!Split sequence"
    ];
    "yaml.schemas" = {
      "https://s3.amazonaws.com/cfn-resource-specifications-us-east-1-prod/schemas/2.15.0/all-spec.json" =
        "*-template.yaml";
    };
    "[yaml]" = {
      "editor.defaultFormatter" = "redhat.vscode-yaml";
    };
    "[helm]" = {
      "editor.defaultFormatter" = "redhat.vscode-yaml";
    };
    "[dockercompose]" = {
      "editor.autoIndent" = "advanced";
      "editor.defaultFormatter" = "redhat.vscode-yaml";
      "editor.insertSpaces" = true;
      "editor.quickSuggestions" = {
        comments = false;
        other = true;
        strings = true;
      };
      "editor.tabSize" = 2;
    };
    "[github-actions-workflow]" = {
      "editor.defaultFormatter" = "redhat.vscode-yaml";
    };

    # Language: CSS/Less
    "css.lint.unknownAtRules" = "ignore";
    "css.lint.unknownProperties" = "ignore";
    "less.lint.unknownAtRules" = "ignore";
    "less.lint.unknownProperties" = "ignore";

    # Language: Typst
    "[typst]" = {
      "editor.defaultFormatter" = "myriad-dreamin.tinymist";
      "editor.formatOnSave" = true;
    };

    # Language: Elixir
    "[elixir]" = {
      "editor.defaultFormatter" = "elixir-lsp.vscode-elixir-ls";
      "editor.formatOnSave" = true;
    };
    "[phoenix-heex]" = {
      "editor.defaultFormatter" = "elixir-lsp.vscode-elixir-ls";
      "editor.formatOnSave" = true;
    };

  };

  settingsJson = builtins.toJSON settings;
  settingsFile = pkgs.writeText "vscode-settings.json" settingsJson;
in
{
  programs.vscode = {
    enable = true;
    package = helpers.mkFakePkg "vscode";
    mutableExtensionsDir = true;

    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          # Nix
          jnoortheen.nix-ide

          # Python
          ms-python.python
          charliermarsh.ruff

          # Go
          golang.go

          # Scala
          scala-lang.scala
          scalameta.metals

          # Elixir
          elixir-lsp.vscode-elixir-ls

          # JavaScript/TypeScript
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode

          # YAML/JSON
          redhat.vscode-yaml

          # Docker/Kubernetes
          ms-kubernetes-tools.vscode-kubernetes-tools

          # Terraform
          hashicorp.terraform

          # GitHub
          github.copilot
          github.copilot-chat

          # Live Share
          ms-vsliveshare.vsliveshare

          # Utilities
          editorconfig.editorconfig
          usernamehw.errorlens
          mikestead.dotenv
          timonwong.shellcheck
        ]
        ++ allThemeExtensions
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # CloudFormation
          {
            name = "cform";
            publisher = "aws-scripting-guy";
            version = "0.0.24";
            sha256 = "0rbjb64y6z36ndzspkph7nmdn16qwqf6crq0p2zmdqbxw3racwsz";
          }
          {
            name = "vscode-cfn-lint";
            publisher = "kddejong";
            version = "0.26.6";
            sha256 = "01bg9nbl9a8zv6wfpb6k366icj5ry8jrlicvpdlfr97ai77nyy7k";
          }

          # GitHub Actions
          {
            name = "vscode-github-actions";
            publisher = "GitHub";
            version = "0.28.2";
            sha256 = "06qy6z1l4mywlxiy21q8xpqvlhck1pp7myaqyb3f1v8zgxy7w5ca";
          }

          # Path/File utilities
          {
            name = "path-intellisense";
            publisher = "christian-kohler";
            version = "2.10.0";
            sha256 = "06x9ksl4bghfpxh4n65d1d7dr11spl140p9ch4mc01nrdibgckbc";
          }

          # Markdown
          {
            name = "vscode-markdownlint";
            publisher = "DavidAnson";
            version = "0.61.1";
            sha256 = "0g0lfxcx7hkigs5780pjrbzwh2c616fcqygzlvwhvfsllj5j5vnw";
          }
          {
            name = "markdown-preview-enhanced";
            publisher = "shd101wyy";
            version = "0.8.20";
            sha256 = "05q4di9b5rklwd60chfarb8j8j75crpbiv8gdg82lqj4mfx0pp7r";
          }

          # Shell
          {
            name = "shell-format";
            publisher = "foxundermoon";
            version = "7.2.8";
            sha256 = "1fkpj78xp40jaa2xh4yw87xl7ww73fg27zbxdq81j2wg793ycyv7";
          }

          # Scala/SBT
          {
            name = "sbt";
            publisher = "itryapitsin";
            version = "0.1.7";
            sha256 = "107xd3l8qr6b9cfdjhk084a10b7nq3sjq4mmfkapmckvynyw419w";
          }

          # JSON
          {
            name = "json";
            publisher = "meezilla";
            version = "0.1.2";
            sha256 = "1i44zpzd35ccyixn9nn4ylhn39h1w9fmkv4wcway8cf8ymqzfzx7";
          }
          {
            name = "prettify-json";
            publisher = "mohsen1";
            version = "0.0.3";
            sha256 = "1spj01dpfggfchwly3iyfm2ak618q2wqd90qx5ndvkj3a7x6rxwn";
          }

          # Text editing utilities
          {
            name = "select-quotes";
            publisher = "stalyo";
            version = "0.0.2";
            sha256 = "19wh2ffnv4qv1wx48sakkqb043i4jlbdmfccqwy4m87f64xwiisc";
          }
          {
            name = "vscode-todo-highlight";
            publisher = "wayou";
            version = "1.0.5";
            sha256 = "1sg4zbr1jgj9adsj3rik5flcn6cbr4k2pzxi446rfzbzvcqns189";
          }

          # Typst
          {
            name = "tinymist";
            publisher = "myriad-dreamin";
            version = "0.14.4";
            sha256 = "sha256-Y8yIAIT0TrrM8ZQSZl4QnVG6uE0F+AwWFvmhLe0ZPto=";
          }

          # Elixir syntax
          {
            name = "vscode-elixir";
            publisher = "mjmcloug";
            version = "1.1.0";
            sha256 = "sha256-EE4x75ljGu212gqu1cADs8bsXLaToVaDnXHOqyDlR04=";
          }

          # Helm/Kubernetes
          {
            name = "vscode-helm";
            publisher = "technosophos";
            version = "0.4.0";
            sha256 = "1rdrv031vnd54md8fq6hinhf8f72cw46sxaka5qpid2ag54dqflj";
          }
          {
            name = "helm-intellisense";
            publisher = "Tim-Koehler";
            version = "0.15.0";
            sha256 = "1sl333j2c0xp2ab8a2f0nncanhf4qs901wnvvbgwhkk07gd1fpaf";
          }
        ];
    };
  };

  # Copy generated settings.json
  home.activation.vscodeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/Library/Application Support/Code/User"
    [ -L "$HOME/Library/Application Support/Code/User/settings.json" ] && rm "$HOME/Library/Application Support/Code/User/settings.json"
    cp ${settingsFile} "$HOME/Library/Application Support/Code/User/settings.json"
    chmod 644 "$HOME/Library/Application Support/Code/User/settings.json"
  '';

  # Copy settings to Antigravity (VSCode fork)
  home.activation.antigravitySettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "$HOME/Library/Application Support/Antigravity/User"
    [ -L "$HOME/Library/Application Support/Antigravity/User/settings.json" ] && rm "$HOME/Library/Application Support/Antigravity/User/settings.json"
    cp ${settingsFile} "$HOME/Library/Application Support/Antigravity/User/settings.json"
    chmod 644 "$HOME/Library/Application Support/Antigravity/User/settings.json"
  '';
}
