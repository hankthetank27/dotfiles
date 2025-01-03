{
  description = "System config flake";

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

  outputs = { self, nix-darwin, nixpkgs, home-manager }:
    let
      darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
      user = "hjackson";
    in
      {
      darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit self user system; };
          modules = [ 
            home-manager.darwinModules.home-manager
            ./nix/system/mac-sys.nix
            ./nix/home/mac-home.nix
          ];
        }
      );
    };
}

