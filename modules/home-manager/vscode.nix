{ config, pkgs, ... }:

let
  theme = import ../shared/theme.nix;
  # Fake package for Homebrew-installed VSCode
  fakePkg = pkgs.runCommand "vscode" {} "mkdir -p $out/bin" // {
    pname = "vscode";
    version = "0.0.0";
    meta.mainProgram = "code";
  };
in
{
  programs.vscode = {
    enable = true;
    package = fakePkg; # Actual app installed via Homebrew

    profiles.default = {
      userSettings = {
        # Theme & Appearance
        "workbench.colorTheme" = "Monokai Pro (Filter Ristretto)";
        "workbench.iconTheme" = "Monokai Pro (Filter Ristretto) Icons";
        "workbench.sideBar.location" = "right";
        "workbench.startupEditor" = "none";
        "workbench.colorCustomizations" = {
          "titleBar.foreground" = "#00000000";
          "titleBar.activeForeground" = "#00000000";
          "titleBar.background" = "#00000000";
          "titleBar.activeBackground" = "#00000000";
        };

        # Font
        "editor.fontFamily" = theme.font.familyCondensed;
        "editor.fontLigatures" = "'calt', 'liga', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09'";
        "editor.codeLensFontFamily" = theme.font.family;
        "terminal.integrated.fontFamily" = theme.font.familyCondensed;

        # Editor Behavior
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "editor.snippetSuggestions" = "top";
        "editor.inlineSuggest.enabled" = true;
        "editor.accessibilitySupport" = "off";

        # Files
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 500;
        "files.associations" = { "*.tex" = "latex"; };
        "files.exclude" = {
          ".bloop" = true;
          ".bsp" = true;
          ".metals" = true;
          ".vscode" = true;
          "**/*_templ.go" = true;
          "**/*_templ.txt" = true;
          "**/metals.sbt" = true;
          "project/project" = true;
          "project/target" = true;
        };
        "files.watcherExclude" = {
          "**/.git/objects/**" = true;
          "**/.git/subtree-cache/**" = true;
          "**/node_modules/**" = true;
          "**/.direnv/**" = true;
          "**/.venv/**" = true;
          "**/.bloop" = true;
          "**/.metals" = true;
          "**/.ammonite" = true;
        };

        # Search
        "search.exclude" = {
          "**/.git/**" = true;
          "**/.bloop" = true;
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
        "git.replaceTagsWhenPull" = true;
        "git.openRepositoryInParentFolders" = "never";
        "diffEditor.ignoreTrimWhitespace" = false;

        # Terminal
        "terminal.integrated.profiles.osx" = {
          "zsh (login)" = { path = "zsh"; args = ["-l"]; };
        };
        "terminal.integrated.defaultProfile.osx" = "zsh (login)";

        # Explorer
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmPasteNative" = false;

        # Privacy
        "telemetry.telemetryLevel" = "off";

        # Security
        "security.workspace.trust.untrustedFiles" = "open";

        # Extensions
        "errorLens.enabled" = true;
        "liveshare.guestApprovalRequired" = true;

        # GitHub Copilot
        "github.copilot.enable" = {
          "*" = true;
          "plaintext" = false;
          "markdown" = false;
          "scminput" = false;
        };
        "github.copilot.nextEditSuggestions.enabled" = true;

        # Python
        "python.analysis.typeCheckingMode" = "basic";
        "python.analysis.autoImportCompletions" = true;
        "python.analysis.autoFormatStrings" = true;
        "python.analysis.diagnosticMode" = "workspace";
        "ruff.configurationPreference" = "filesystemFirst";
        "ruff.fixAll" = true;
        "editor.codeActionsOnSave" = { "source.fixAll.ruff" = "explicit"; };

        # JavaScript/TypeScript
        "typescript.updateImportsOnFileMove.enabled" = "always";

        # Go
        "go.toolsManagement.autoUpdate" = true;

        # Scala/Metals
        "metals.enableIndentOnPaste" = true;

        # CSS/LESS
        "css.lint.unknownAtRules" = "ignore";
        "css.lint.unknownProperties" = "ignore";
        "less.lint.unknownAtRules" = "ignore";
        "less.lint.unknownProperties" = "ignore";

        # YAML
        "yaml.format.enable" = true;
        "yaml.maxItemsComputed" = 15000;
        "yaml.customTags" = [
          "!And" "!And sequence" "!If" "!If sequence" "!Not" "!Not sequence"
          "!Equals" "!Equals sequence" "!Or" "!Or sequence" "!FindInMap"
          "!FindInMap sequence" "!Base64" "!Join" "!Join sequence" "!Cidr"
          "!Ref" "!Sub" "!Sub sequence" "!GetAtt" "!GetAZs" "!ImportValue"
          "!ImportValue sequence" "!Select" "!Select sequence" "!Split" "!Split sequence"
        ];
        "json.schemas" = [{
          fileMatch = ["*-template.json"];
          url = "https://s3.amazonaws.com/cfn-resource-specifications-us-east-1-prod/schemas/2.15.0/all-spec.json";
        }];
        "yaml.schemas" = {
          "https://s3.amazonaws.com/cfn-resource-specifications-us-east-1-prod/schemas/2.15.0/all-spec.json" = "*-template.yaml";
        };

        # LaTeX
        "latex-workshop.latex.recipes" = [
          { name = "xelatexmk"; tools = ["xelatexmk"]; }
          { name = "pdflatex -> bibtex -> pdflatex*2"; tools = ["pdflatex" "bibtex" "pdflatex" "pdflatex"]; }
        ];
        "latex-workshop.latex.tools" = [
          { name = "xelatexmk"; command = "latexmk"; args = ["-xelatex" "-synctex=1" "-interaction=nonstopmode" "-file-line-error" "-recorder" "%DOC%"]; }
          { name = "pdflatex"; command = "pdflatex"; args = ["-synctex=1" "-interaction=nonstopmode" "-file-line-error" "-recorder" "%DOC%"]; }
          { name = "bibtex"; command = "bibtex"; args = ["%DOCFILE%"]; }
        ];
        "latex-workshop.latex.autoBuild.run" = "onFileChange";
        "latex-workshop.view.pdf.viewer" = "tab";
        "latex-workshop.view.pdf.ref.viewer" = "tabOrBrowser";
        "latex-workshop.latex.autoClean.run" = "onSucceeded";
        "latex-workshop.latex.clean.fileTypes" = [
          "*.aux" "*.bbl" "*.blg" "*.log" "*.fls" "*.out" "*.toc"
          "*.acn" "*.acr" "*.alg" "*.glg" "*.glo" "*.gls" "*.ist"
          "*.loa" "*.lot" "*.synctex.gz" "*.fdb_latexmk"
        ];

        # Docker
        "docker.extension.enableComposeLanguageServer" = false;
        "docker.extension.dockerEngineAvailabilityPrompt" = false;

        # GitHub Actions
        "github-actions.use-enterprise" = false;

        # Makefile
        "makefile.configureOnOpen" = true;

        # GitLens
        "gitlens.advanced.messages" = {
          "suppressIntegrationDisconnectedTooManyFailedRequestsWarning" = true;
        };
      };

      # Language-specific settings
      userSettings."[python]" = {
        "editor.formatOnType" = true;
        "editor.defaultFormatter" = "charliermarsh.ruff";
      };
      userSettings."[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      userSettings."[sbt]" = { "editor.formatOnSave" = true; };
      userSettings."[elm]" = { "editor.formatOnSave" = true; };
      userSettings."[dockercompose]" = {
        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
        "editor.autoIndent" = "advanced";
        "editor.quickSuggestions" = { "other" = true; "comments" = false; "strings" = true; };
        "editor.defaultFormatter" = "redhat.vscode-yaml";
      };
      userSettings."[github-actions-workflow]" = {
        "editor.defaultFormatter" = "redhat.vscode-yaml";
      };
    };
  };
}
