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
        pkgs = import nixpkgs { inherit system; };
      in {
        nixosConfigurations = {
          ci-host = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              disko.nixosModules.disko
              ./configuration.nix
              ./disko.nix
            ];
            configuration = {
              # If you want to override some config here, do so
            };
            specialArgs = {
              pkgs = pkgs;
              lib = nixpkgs.lib;
              self = self;
              system = system;
            };
          };
        };

        packages = {}; # optional

        templates.default = {
          path = ./.;
          description = "NixOS template with Disko, Docker, Jenkins, etc.";
        };
      }
    );
}
