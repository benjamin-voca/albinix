{ config, pkgs, lib, ... }:

let
  hostConfig = lib.removeSuffix "\n" (builtins.readFile "/etc/hostname");
in
{
  imports = [
    # ./disko.nix
    /etc/nixos/hardware-configuration.nix
    ./packages.nix
    ./hosts/${hostConfig}.nix
  ];

  system.stateVersion = "25.05";

  # Bootloader for BIOS/UEFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  # services.openssh.settings.PermitRootLogin = "no";
  security.sudo.wheelNeedsPassword = false;

  # Set your time zone.
  time.timeZone = "Europe/Sarajevo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;
  # Users
  users.users = {
    benjamin = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILaEuHKb7PS/LyaBxvNzIcVzMOW0aDVHFnauM9pSjxm8 benjamin@Benjamins-MacBook-Pro.local"
      ];
    };
    klajdi = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQisXyPG28p3bjlL6slxTsZWdQRDBcIq0eKf388kjJk klajdimac@gmail.com"
      ];
    };
    gjoni = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFikrtxTY3L49JN5OmWCFaNRAFBb6InjxPiXmc6iSCa2 gjonhajdari@chon-mekbuk.local"
      ];
    };
  };
  
  # Packages
  environment.systemPackages = with pkgs; [
    git
    docker-compose
    docker
    podman
    jujutsu
    yazi
    neovim
    helix
    zoxide
    qemu
    virtiofsd
    podman-compose
    pnpm
    nodejs
    phpPackages.composer
    php
    lsof
    python314
    kubectl
    kubernetes-helm
  ];

  # Jenkins
  services.jenkins = {
    enable = true;
    port = 8080;
  };

  # Docker
  virtualisation = {
    docker.enable = true;
    vmware.guest.enable = true;
  };

  networking.useDHCP = false;
  networking.useNetworkd = false;


  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 80 27017 37017 37018 37019 5555 ];
    # allowedTCPPortRanges = [
    #   { from = 5100; to = 8999; }
    # ];
    # allowedUDPPortRanges = [
    #   { from = 5100; to = 8999; }
    # ];
  };
  services.kubernetes = {
    roles = [ "master" "node" ]; # all-in-one node
    masterAddress = "127.0.0.1";
    apiserverAddress = "0.0.0.0";
    easyCerts = true; # auto-generate certs
    kubelet.extraOpts = "--fail-swap-on=false";
  };

  # Fish shell
  programs.fish.enable = true;

  # Hostname and networking
  networking.networkmanager.enable = true;

  # Optional: enable X11 if GUI is ever needed
  # services.xserver.enable = true;
}
