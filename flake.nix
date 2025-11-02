{
  description = "Nix-based Darwin system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nix-darwin, home-manager, ... }:
    let
      # User configuration - Change these values for your environment
      userConfig = {
        username = "your_username";
        fullName = "Your Full Name";
        email = "your.email@example.com";
      };
    in
    {
      darwinConfigurations = {
        # Main macbook configuration
        macbook = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";  # Change to "x86_64-darwin" for Intel Macs
          specialArgs = { inherit userConfig; };
          modules = [
            ./hosts/macbook/darwin.nix

            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit userConfig; };
                users.${userConfig.username} = import ./hosts/macbook/home.nix;
              };
            }
          ];
        };
      };
    };
}
