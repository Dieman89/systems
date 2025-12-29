{ username, ... }:

let
  flakeDir = "/Users/${username}/systems";
in
{
  # Daily nix flake update with notification
  launchd.agents.nix-flake-update = {
    serviceConfig = {
      Label = "com.nix.flake-update";
      ProgramArguments = [
        "/bin/bash"
        "-c"
        ''
          cd ${flakeDir}

          # Run flake update
          /run/current-system/sw/bin/nix flake update 2>/dev/null

          # Check if flake.lock changed
          if /run/current-system/sw/bin/git diff --quiet flake.lock 2>/dev/null; then
            # No changes
            exit 0
          else
            # Updates available - send notification
            /usr/bin/osascript -e 'display notification "Run: darwin-rebuild switch --flake ." with title "Nix Updates Available" subtitle "flake.lock has been updated"'
          fi
        ''
      ];
      StartCalendarInterval = [
        {
          Hour = 9;
          Minute = 0;
        }
      ];
      StandardOutPath = "/tmp/nix-flake-update.log";
      StandardErrorPath = "/tmp/nix-flake-update.err";
    };
  };
}
