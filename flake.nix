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
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nix-darwin, nixpkgs, home-manager, fenix }:
    let
      darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
      user = "hjackson";

      mkApp = scriptName: system: {
        type = "app";
        program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
          #!/usr/bin/env bash
          PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
          echo "Running ${scriptName} for ${system}"
          exec ${self}/nix/scripts/${system}/${scriptName}
        '')}/bin/${scriptName}";
      };

      mkDarwinApps = system: {
        "build" = mkApp "build" system;
        "build-switch" = mkApp "build-switch" system;
      };

    in
      {
      apps = nixpkgs.lib.genAttrs darwinSystems mkDarwinApps;
      darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit self user system fenix; };
          modules = [ 
            home-manager.darwinModules.home-manager
            ./nix/system/mac-sys.nix
            ./nix/home/mac-home.nix
          ];
        }
      );
    };
}

