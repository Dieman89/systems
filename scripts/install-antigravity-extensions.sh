#!/bin/bash
# Install VSCode extensions into Antigravity
# Based on extensions defined in modules/home-manager/vscode.nix

ANTIGRAVITY="/Applications/Antigravity.app/Contents/Resources/app/bin/antigravity"

extensions=(
  # Nix
  "jnoortheen.nix-ide"

  # Python
  "ms-python.python"
  "charliermarsh.ruff"

  # Go
  "golang.go"

  # Scala
  "scala-lang.scala"
  "scalameta.metals"
  "itryapitsin.sbt"

  # JavaScript/TypeScript
  "dbaeumer.vscode-eslint"
  "esbenp.prettier-vscode"

  # YAML/JSON
  "redhat.vscode-yaml"
  "meezilla.json"
  "mohsen1.prettify-json"

  # Docker/Kubernetes
  "ms-kubernetes-tools.vscode-kubernetes-tools"
  "technosophos.vscode-helm"
  "Tim-Koehler.helm-intellisense"

  # Terraform
  "hashicorp.terraform"

  # CloudFormation
  "aws-scripting-guy.cform"
  "kddejong.vscode-cfn-lint"

  # GitHub
  "me-dutour-mathieu.vscode-github-actions"

  # Live Share
  "ms-vsliveshare.vsliveshare"

  # LaTeX
  "james-yu.latex-workshop"
  "tecosaur.latex-utilities"

  # Markdown
  "DavidAnson.vscode-markdownlint"
  "shd101wyy.markdown-preview-enhanced"

  # Shell
  "timonwong.shellcheck"
  "foxundermoon.shell-format"

  # Utilities
  "editorconfig.editorconfig"
  "usernamehw.errorlens"
  "mikestead.dotenv"
  "christian-kohler.path-intellisense"
  "stalyo.select-quotes"
  "wayou.vscode-todo-highlight"

  # Theme (already installed, but included for completeness)
  "monokai.theme-monokai-pro-vscode"
)

echo "Installing ${#extensions[@]} extensions into Antigravity..."
echo ""

for ext in "${extensions[@]}"; do
  echo "Installing: $ext"
  "$ANTIGRAVITY" --install-extension "$ext" --force 2>/dev/null
done

echo ""
echo "Done! Restart Antigravity to load all extensions."
