_:

{
  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Allow 1Password to connect to Zen browser (nix-wrapped)
  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      .zen-wrapped
      zen
    '';
  };
}
