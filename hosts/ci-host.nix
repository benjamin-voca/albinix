{ config, pkgs, ... }:

{
  networking.hostName = "ci-host";

  networking.interfaces.ens34.ipv4.addresses = [{
    address = "185.177.31.11";
    prefixLength = 25;
  }];

  networking.defaultGateway = "185.177.31.1";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
  users.users.programmers = {
    isNormalUser = true;
    description = "CI Host User";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFsCLJyuLCIOlpvw3u5XIdM1UZA4MbTKNuy5KywYgIVt toshibo@DESKTOP-TP1EL38"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPu78got5AUIQzL2RawwR4gEcx9sm1XImPPMHi7zIriQ andigashi2005@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK7TUOEBXb+bu7wSE0fkZcmpdYY7WDP3iMnfAhFdP+hV Joni"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDuCuBFq7m44b4aCm42icdYaGHBu1qRWbYIthNuscZyJq8QAaYr6P3B85+NtIYusJXLELzVBIfLHe5bmYuREbaoCnvti7a2mQOh2D6GhqB6YwhsdCvcauCc76E2/hJ+1TdeNAxWl5zGn/rPeACj2/ETernud09JABV/1snWBjMGs2jjhHd4rREN0LTV5nj2K33X0r5QsQf/2OghHYKA5QqA9+1oKFVRikhiafTYJOxXCb0x+5iosStZ9a5DTJT+KvOK8Y3XogDCRIxIuOUMAVkS2i9ObqvCxeylysRONTZHur85p/pnu1I24i1n75IfKZd4IfjwuDMSg480f35Qaj7H3J88gJhDZqdmZnH51SD1ZTXqFYtaRGfPbQJeMtuff5I5nZ5FzEX2e72L7TatHv9Ym91YUSDGQDwN8UjhA3Ncde5eeHIGv8TcbvxdBfKJpMqYFTH6Tn8R+AnqRsq9sb/ThVRTyBUb8fYpyfiLarWvgg1yyk1PvJvQTC0urxqLFKk= shqiponjedani@Shqiponjes-MacBook-Air.local"
    ];
  };
}
