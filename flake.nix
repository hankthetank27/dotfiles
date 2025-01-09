{
  description = "System config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
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
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

  };

  outputs =
    {
      self,
      nix-darwin,
      nix-homebrew,
      nixos-wsl,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      nixpkgs,
      home-manager,
      fenix,
    }@inputs:

    let
      user = "hjackson";

      darwinSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      linuxSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      mkApp = scriptName: system: {
        type = "app";
        program = "${
          (nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
            #!/usr/bin/env bash
            PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
            echo "Running ${scriptName} for ${system}"
            exec ${self}/nix/scripts/${system}/${scriptName}
          '')
        }/bin/${scriptName}";
      };

      mkDarwinApps = system: {
        "build" = mkApp "build" system;
        "build-switch" = mkApp "build-switch" system;
      };

    in
    {
      apps = nixpkgs.lib.genAttrs darwinSystems mkDarwinApps;

      darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (
        system:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = {
            inherit
              self
              user
              system
              fenix
              ;
          };
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                inherit user;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./nix/hosts/macos/configuration.nix
          ];
        }
      );

      nixosConfigurations = {
        wsl =
          let
            system = "x86_64-linux";
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit
                self
                user
                system
                fenix
                inputs
                ;
            };
            modules = [
              nixos-wsl.nixosModules.wsl
              home-manager.nixosModules.home-manager
              ./nix/hosts/wsl/configuration.nix
            ];
          };
      };
      # // nixpkgs.lib.genAttrs linuxSystems (
      #   system:
      #   nixpkgs.lib.nixosSystem {
      #     inherit system;
      #     specialArgs = {
      #       inherit
      #         self
      #         user
      #         system
      #         fenix
      #         inputs
      #         ;
      #     };
      #     modules = [
      #       home-manager.nixosModules.home-manager
      #       ./nix/hosts/nixos/configuration.nix
      #     ];
      #   }
      # );
    };
}
