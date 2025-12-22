#!/usr/bin/env bash
# Health check script - verifies system matches nix configuration

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(dirname "$SCRIPT_DIR")"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

pass() { echo -e "${GREEN}✓${NC} $1"; }
fail() { echo -e "${RED}✗${NC} $1"; FAILED=1; }
warn() { echo -e "${YELLOW}!${NC} $1"; }

FAILED=0

echo "Running health checks..."
echo

# Nix & Homebrew
echo "==> Core"
command -v nix &>/dev/null && pass "nix" || fail "nix"
command -v darwin-rebuild &>/dev/null && pass "darwin-rebuild" || fail "darwin-rebuild"
command -v brew &>/dev/null && pass "homebrew" || fail "homebrew"
[ -f ~/.config/nix/nix.conf ] && grep -q "flakes" ~/.config/nix/nix.conf && pass "flakes enabled" || warn "flakes not in nix.conf"

# Shell tools (cli.nix)
echo
echo "==> CLI tools"
command -v zsh &>/dev/null && pass "zsh" || fail "zsh"
command -v starship &>/dev/null && pass "starship" || fail "starship"
command -v atuin &>/dev/null && pass "atuin" || fail "atuin"
command -v eza &>/dev/null && pass "eza" || fail "eza"
command -v bat &>/dev/null && pass "bat" || fail "bat"
command -v zoxide &>/dev/null && pass "zoxide" || fail "zoxide"
command -v rg &>/dev/null && pass "ripgrep" || fail "ripgrep"
command -v fd &>/dev/null && pass "fd" || fail "fd"
command -v jq &>/dev/null && pass "jq" || fail "jq"
command -v yq &>/dev/null && pass "yq" || fail "yq"
command -v htop &>/dev/null && pass "htop" || fail "htop"
command -v btop &>/dev/null && pass "btop" || fail "btop"
command -v tree &>/dev/null && pass "tree" || fail "tree"
command -v tldr &>/dev/null && pass "tldr" || fail "tldr"
command -v duf &>/dev/null && pass "duf" || fail "duf"
command -v procs &>/dev/null && pass "procs" || fail "procs"
command -v fastfetch &>/dev/null && pass "fastfetch" || fail "fastfetch"
command -v thefuck &>/dev/null && pass "thefuck" || warn "thefuck (homebrew)"

# Dev tools (dev.nix)
echo
echo "==> Dev tools"
command -v git &>/dev/null && pass "git" || fail "git"
command -v gh &>/dev/null && pass "gh" || fail "gh"
command -v delta &>/dev/null && pass "delta" || fail "delta"
command -v direnv &>/dev/null && pass "direnv" || fail "direnv"
command -v mise &>/dev/null && pass "mise" || fail "mise"
command -v pre-commit &>/dev/null && pass "pre-commit" || fail "pre-commit"

# Nix tools
echo
echo "==> Nix tools"
command -v nil &>/dev/null && pass "nil" || fail "nil"
command -v nixd &>/dev/null && pass "nixd" || fail "nixd"
command -v nixfmt &>/dev/null && pass "nixfmt" || fail "nixfmt"
command -v statix &>/dev/null && pass "statix" || fail "statix"

# Languages
echo
echo "==> Languages"
command -v go &>/dev/null && pass "go" || fail "go"
command -v rustc &>/dev/null && pass "rust" || warn "rust (run: rustup default stable)"
command -v node &>/dev/null && pass "node" || fail "node"
command -v python3 &>/dev/null && pass "python" || fail "python"
command -v zig &>/dev/null && pass "zig" || fail "zig"
command -v elixir &>/dev/null && pass "elixir" || fail "elixir"
command -v sbt &>/dev/null && pass "sbt" || fail "sbt"

# Linters & formatters
echo
echo "==> Linters & formatters"
command -v ruff &>/dev/null && pass "ruff" || fail "ruff"
command -v mypy &>/dev/null && pass "mypy" || fail "mypy"
command -v golangci-lint &>/dev/null && pass "golangci-lint" || fail "golangci-lint"
command -v prettier &>/dev/null && pass "prettier" || fail "prettier"

# Kubernetes (cloud.nix)
echo
echo "==> Kubernetes"
command -v kubectl &>/dev/null && pass "kubectl" || fail "kubectl"
command -v helm &>/dev/null && pass "helm" || fail "helm"
command -v k9s &>/dev/null && pass "k9s" || fail "k9s"
command -v kubectx &>/dev/null && pass "kubectx" || fail "kubectx"
command -v stern &>/dev/null && pass "stern" || fail "stern"
command -v kustomize &>/dev/null && pass "kustomize" || fail "kustomize"

# GitOps & Infrastructure
echo
echo "==> GitOps & Infrastructure"
command -v argocd &>/dev/null && pass "argocd" || fail "argocd"
command -v flux &>/dev/null && pass "flux" || fail "flux"
command -v terraform &>/dev/null && pass "terraform" || fail "terraform"

# Security & Containers
echo
echo "==> Security & Containers"
command -v trivy &>/dev/null && pass "trivy" || fail "trivy"
command -v nmap &>/dev/null && pass "nmap" || fail "nmap"
command -v age &>/dev/null && pass "age" || fail "age"
command -v dive &>/dev/null && pass "dive" || fail "dive"

# Cloud
echo
echo "==> Cloud"
command -v aws &>/dev/null && pass "aws" || fail "aws"
command -v granted &>/dev/null && pass "granted" || warn "granted (run: assume)"
command -v http &>/dev/null && pass "httpie" || fail "httpie"

# 1Password
echo
echo "==> 1Password"
command -v op &>/dev/null && pass "1password-cli" || fail "1password-cli"
[ -S ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ] && pass "ssh agent socket" || warn "ssh agent socket not found"

# Fonts
echo
echo "==> Fonts"
[ -f "$REPO_DIR/assets/fonts.zip" ] && pass "fonts decrypted" || warn "fonts not decrypted (run: decrypt-fonts)"

# Git config
echo
echo "==> Git config"
git config --get user.name &>/dev/null && pass "user.name: $(git config --get user.name)" || fail "user.name not set"
git config --get user.email &>/dev/null && pass "user.email set" || fail "user.email not set"
git config --get commit.gpgsign &>/dev/null && pass "commit signing enabled" || warn "commit signing not enabled"

# Pre-commit hooks
echo
echo "==> Pre-commit"
[ -f "$REPO_DIR/.git/hooks/pre-commit" ] && pass "hooks installed" || warn "hooks not installed (run: pre-commit install)"

echo
if [ $FAILED -eq 0 ]; then
  echo -e "${GREEN}All critical checks passed!${NC}"
else
  echo -e "${RED}Some checks failed. Run 'rebuild' to fix.${NC}"
  exit 1
fi
