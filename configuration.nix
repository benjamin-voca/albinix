{ config, pkgs, ... }:

{
  imports = [
    ./disko.nix
  ];

  system.stateVersion = "24.05";

  # Enable SSH
  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.PermitRootLogin = "no";

  # Users
  users.users={
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
  virtualisation.docker.enable = true;

  # Podman
  virtualisation.podman.enable = true;

  # Firewall - Open necessary ports
  networking.firewall.allowedTCPPorts = [ 
    22    # SSH
    8080  # Jenkins
  ];

  # Allow podman to expose ports to host
  virtualisation.podman.defaultNetwork.settings.dns_enabled = true;

  # Optional: Enable fish shell globally
  programs.fish.enable = true;

  # Optional: Set hostname
  networking.hostName = "ci-host";

  # Optional: Enable networking
  networking.networkmanager.enable = true;

  # Optional: Enable graphical environment
  # services.xserver.enable = true;
}
