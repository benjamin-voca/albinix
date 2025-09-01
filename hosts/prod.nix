{ config, pkgs, ... }:

{
  networking.hostName = "prod";

  networking.interfaces.ens34.ipv4.addresses = [{
    address = "";
    prefixLength = 25;
  }];

  networking.defaultGateway = "";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
}
