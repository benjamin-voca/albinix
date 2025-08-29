{ config, pkgs, ... }:

{
  networking.hostName = "ci-host";

  networking.interfaces.ens34.ipv4.addresses = [{
    address = "185.177.31.11";
    prefixLength = 25;
  }];

  networking.defaultGateway = "185.177.31.1";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
}
