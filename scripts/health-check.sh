#!/usr/bin/env bash
# Health check script - verifies system matches nix configuration

set -e

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

# Nix
echo "==> Nix"
command -v nix &>/dev/null && pass "nix installed" || fail "nix not installed"
command -v darwin-rebuild &>/dev/null && pass "darwin-rebuild installed" || fail "darwin-rebuild not installed"
[ -f ~/.config/nix/nix.conf ] && grep -q "flakes" ~/.config/nix/nix.conf && pass "flakes enabled" || warn "flakes not in nix.conf"

# Homebrew
echo
echo "==> Homebrew"
command -v brew &>/dev/null && pass "homebrew installed" || fail "homebrew not installed"

# Shell tools
echo
echo "==> Shell tools"
command -v zsh &>/dev/null && pass "zsh" || fail "zsh"
command -v starship &>/dev/null && pass "starship" || fail "starship"
command -v atuin &>/dev/null && pass "atuin" || fail "atuin"
command -v eza &>/dev/null && pass "eza" || fail "eza"
command -v bat &>/dev/null && pass "bat" || fail "bat"
command -v zoxide &>/dev/null && pass "zoxide" || fail "zoxide"
command -v fzf &>/dev/null && pass "fzf" || warn "fzf (optional)"
command -v mise &>/dev/null && pass "mise" || fail "mise"

# Dev tools
echo
echo "==> Dev tools"
command -v git &>/dev/null && pass "git" || fail "git"
command -v gh &>/dev/null && pass "gh" || fail "gh"
command -v delta &>/dev/null && pass "delta" || fail "delta"
command -v nixfmt &>/dev/null && pass "nixfmt" || fail "nixfmt"
command -v statix &>/dev/null && pass "statix" || fail "statix"

# Languages
echo
echo "==> Languages"
command -v go &>/dev/null && pass "go" || warn "go"
command -v rustc &>/dev/null && pass "rust" || warn "rust"
command -v node &>/dev/null && pass "node" || warn "node"
command -v python3 &>/dev/null && pass "python" || warn "python"

# Cloud tools
echo
echo "==> Cloud tools"
command -v kubectl &>/dev/null && pass "kubectl" || warn "kubectl"
command -v terraform &>/dev/null && pass "terraform" || warn "terraform"
command -v aws &>/dev/null && pass "aws" || warn "aws"

# 1Password
echo
echo "==> 1Password"
command -v op &>/dev/null && pass "1password-cli" || fail "1password-cli"
[ -S ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ] && pass "ssh agent socket" || warn "ssh agent socket not found"

# Fonts
echo
echo "==> Fonts"
[ -f ~/systems/assets/fonts.zip ] && pass "fonts decrypted" || warn "fonts not decrypted (run decrypt-fonts)"

# Git config
echo
echo "==> Git"
git config --get user.name &>/dev/null && pass "git user.name set" || fail "git user.name not set"
git config --get user.email &>/dev/null && pass "git user.email set" || fail "git user.email not set"
git config --get commit.gpgsign &>/dev/null && pass "git signing enabled" || warn "git signing not enabled"

echo
if [ $FAILED -eq 0 ]; then
  echo -e "${GREEN}All critical checks passed!${NC}"
else
  echo -e "${RED}Some checks failed. Run 'rebuild' to fix.${NC}"
  exit 1
fi
