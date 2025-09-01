{ config, pkgs, ... }:

{
  networking.hostName = "prod";

  networking.interfaces.ens34.ipv4.addresses = [{
    address = "185.177.31.12";
    prefixLength = 25;
  }];

  networking.defaultGateway = "185.177.31.12";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
}
