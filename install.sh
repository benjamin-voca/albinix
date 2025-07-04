!#/usr/bin/env sh


sudo nixos-generate-config --root /mnt
sudo cp ./configuration.nix /mnt
sudo cp ./disko.nix /mnt
cd /mnt
sudo nix run github:nix-community/disko -- --mode disko ./disko.nix
sudo nixos-install
