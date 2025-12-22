_:

{
  # Application Firewall
  networking.applicationFirewall = {
    enable = true;
    enableStealthMode = true; # Don't respond to pings
    allowSigned = true; # Allow built-in signed apps
    allowSignedApp = true; # Allow downloaded signed apps
    blockAllIncoming = false; # Only block unsigned
  };

  # Enable Touch ID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Allow 1Password to connect to Zen browser
  environment.etc."1password/custom_allowed_browsers" = {
    text = ''
      .zen-wrapped
      zen
    '';
  };
}
