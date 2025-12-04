{ config, pkgs, ... }:

{
  networking.hostName = "prod";

  networking.interfaces.ens34.ipv4.addresses = [{
    address = "172.16.3.55";
    prefixLength = 24;
  }];

  networking.defaultGateway = "172.16.3.1";
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];
}
