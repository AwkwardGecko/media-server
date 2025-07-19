#/etc/nixos/sys-modules/radarr.nix
{ config, lib, pkgs, ... }
{
  networking.firewall.allowedTCPPorts = [ 7878 ];

  services.radarr = {
    enable = true;
    user = "wings";
    group = "users";
    dataDir = "/var/lib/radarr/";
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
