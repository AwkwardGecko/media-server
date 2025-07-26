#/etc/nixos/sys-modules/sonarr.nix
{ config, lib, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 8989 ];

  services.radarr = {
    enable = true;
    user = "sonarr";
    group = "sonarr";
    dataDir = "/var/lib/sonarr/";
    openFirewall = true;
    settings = {
      server = {
        urlbase = "/sonarr";
        port = 8989;
        bindaddress = "*";
      };
      update = {
        automatically = false;
        mechanism = "external";
      };
    };
  };
}
