{
  description = "NixOS with Disko, Docker, Jenkins, etc.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, disko, ... }:
    let
      systems = flake-utils.lib.defaultSystems;
    in
    flake-utils.lib.eachSystem systems (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages = {}; # optional if you want to define packages per system
      }
    ) // {
      nixosConfigurations.ci-host = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
          ./disko.nix
        ];
      };

      templates.default = {
        path = ./.;
        description = "NixOS template with Disko, Docker, Jenkins, etc.";
      };
    };
}
