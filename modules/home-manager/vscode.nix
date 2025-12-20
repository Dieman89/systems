{ pkgs, lib, ... }:

let
  helpers = import ../shared/helpers.nix { inherit pkgs; };
in
{
  programs.vscode = {
    enable = true;
    package = helpers.mkFakePkg "vscode";
    mutableExtensionsDir = true; # Allow installing extensions via VSCode UI

    profiles.default = {
      extensions =
        with pkgs.vscode-extensions;
        [
          # Nix
          jnoortheen.nix-ide # Full IDE support with nil language server

          # Python
          ms-python.python
          charliermarsh.ruff

          # Go
          golang.go

          # Scala
          scala-lang.scala
          scalameta.metals

          # JavaScript/TypeScript
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode # TODO: Migration to prettier.prettier-vscode when v12 stabilizes

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
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # Theme
          {
            name = "theme-monokai-pro-vscode";
            publisher = "monokai";
            version = "2.0.11";
            sha256 = "03sbsi0m8n5w6vwwshafllm4iy0wapf0qnyym2m50w3cynrl5kmw";
          }

          # LaTeX
          {
            name = "latex-workshop";
            publisher = "james-yu";
            version = "10.12.0";
            sha256 = "0pza1pvrk7xdrmk1xy0v4ayvzb59pd3n4z5iza7m54i1kr53pd2j";
          }
          {
            name = "latex-utilities";
            publisher = "tecosaur";
            version = "0.4.14";
            sha256 = "0fywc152p8b8nfjdkwk7826wmvza7vdkg1daf4dsbrqdaz6cgihs";
          }

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
            publisher = "me-dutour-mathieu";
            version = "3.0.1";
            sha256 = "1cj0wy7mfx9fwx9wijpg5nbyy5z4xv1c0838axkqj91gzf9rk6i3";
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
      # Note: Monokai Pro requires entering license key in VSCode after installation
    };
  };

  # Copy settings.json (writable, no symlink warnings)
  home.activation.vscodeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
    mkdir -p "$VSCODE_USER_DIR"
    [ -L "$VSCODE_USER_DIR/settings.json" ] && rm "$VSCODE_USER_DIR/settings.json"
    cp ${../../config/vscode/settings.json} "$VSCODE_USER_DIR/settings.json"
    chmod 644 "$VSCODE_USER_DIR/settings.json"
  '';

  # Copy settings.json to Antigravity (VSCode fork)
  home.activation.antigravitySettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ANTIGRAVITY_USER_DIR="$HOME/Library/Application Support/Antigravity/User"
    mkdir -p "$ANTIGRAVITY_USER_DIR"
    [ -L "$ANTIGRAVITY_USER_DIR/settings.json" ] && rm "$ANTIGRAVITY_USER_DIR/settings.json"
    cp ${../../config/vscode/settings.json} "$ANTIGRAVITY_USER_DIR/settings.json"
    chmod 644 "$ANTIGRAVITY_USER_DIR/settings.json"
  '';
}
