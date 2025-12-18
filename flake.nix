{
  description = "macOS system configuration with nix-darwin and home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      system = builtins.currentSystem;
      username = "dieman";
      hostname = "macbook";
    in
    {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        inherit system;

        modules = [
          ./modules/nix-darwin

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${username} = import ./modules/home-manager;
            };

            users.users.${username} = {
              name = username;
              home = "/Users/${username}";
            };
          }
        ];
      };

      # Default to current hostname
      darwinConfigurations.default = self.darwinConfigurations.${hostname};
    };
}
