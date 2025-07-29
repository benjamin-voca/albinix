{ config, pkgs, ... }:

{
  imports = [
    # ./disko.nix
    ./hardware-configuration.nix
    ./packages.nix
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
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOgJOT75+//lRa1pA9Y83Kj94+QgG5lJOdjrCW330km klajdi.gashi01@gmail.com"
      ];
    };
    gjoni = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" "podman" ];
      shell = pkgs.zsh;
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
  # Podman
    podman.enable = true;
    podman.defaultNetwork.settings.dns_enabled = true;
  };

  # VMware guest tools
  # services.vmwareGuest.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 ];
    allowedTCPPortRanges = [
      { from = 8000; to = 8999; }
    ];
    allowedUDPPortRanges = [
      { from = 8000; to = 8999; }
    ];
  };

  # Fish shell
  programs.fish.enable = true;

  # Hostname and networking
  networking.hostName = "ci-host";
  networking.networkmanager.enable = true;

  # Optional: enable X11 if GUI is ever needed
  # services.xserver.enable = true;
}
