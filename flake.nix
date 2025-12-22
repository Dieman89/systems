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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      zen-browser,
      ...
    }@inputs:
    let
      system = "aarch64-darwin";
      username = "dieman";
      hostname = "macbook";
    in
    {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit username; };

        modules = [
          ./modules/nix-darwin

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs system; };
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
