{
  description = "NixOS with Disko, Docker, Jenkins, etc.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    disko.url = "github:nix-community/disko";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, disko, ... }:
    let
      system = "x86_64-linux";
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
    };
}
