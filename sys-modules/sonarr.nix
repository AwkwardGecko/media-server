#/etc/nixos/sys-modules/sonarr.nix
{ config, lib, pkgs, ... }
{
  networking.firewall.allowedTCPPorts = [ 8989 ];

  services.radarr = {
    enable = true;
    user = "wings";
    group = "users";
    dataDir = "/var/lib/sonarr/";
    openFirewall = true;
    settings = {
      server = {
        urlbase = "/radar";
        port = 7878;
        bindaddress = "*";
      };
      update = {
        automatically = false;
        mechanism = "external";
      };
    };
  };
}
