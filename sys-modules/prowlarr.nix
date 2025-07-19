#/etc/nixos/sys-modules/prowlarr.nix
{ config, lib, pkgs, ... }:
{

  networking.firewall.allowedTCPPorts = [
    9696
  ];

  services.prowlarr = {
    enable = true;
    openFirewall = true;
    settings = {
      server = {
        #update = "automatically";
        urlbase = "192.168.1.157";
        port = 9696;
        bindaddress = "*";
      };
    };
  };
}
