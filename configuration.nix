{ config, pkgs, ... }:

{
  imports = [
    ./disko.nix
  ];

  system.stateVersion = "24.05";

  # Bootloader for BIOS/UEFI
  boot.loader.grub = {
    enable = true;
    devices = [ "/dev/sda" ]; # not "/dev/sda1"
    useOSProber = false;
    efiSupport = true;
    # efiInstallAsRemovable = true;
  };
  boot.loader.efi.canTouchEfiVariables = true;
  # Enable SSH
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "no";

  # Users
  users.users = {
    benjamin = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "podman" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILaEuHKb7PS/LyaBxvNzIcVzMOW0aDVHFnauM9pSjxm8 benjamin@Benjamins-MacBook-Pro.local"
      ];
    };
    klajdi = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "podman" ];
      shell = pkgs.fish;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDOgJOT75+//lRa1pA9Y83Kj94+QgG5lJOdjrCW330km klajdi.gashi01@gmail.com"
      ];
    };
    gjoni = {
      isNormalUser = true;
      extraGroups = [ "wheel" "docker" "podman" ];
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

  # Firewall
  networking.firewall.allowedTCPPorts = [ 
    22    # SSH
    8080  # Jenkins
  ];

  # Fish shell
  programs.fish.enable = true;

  # Hostname and networking
  networking.hostName = "ci-host";
  networking.networkmanager.enable = true;

  # Optional: enable X11 if GUI is ever needed
  # services.xserver.enable = true;
}
