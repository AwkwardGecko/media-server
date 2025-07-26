#/etc/nixos/sys-modules/radarr.nix
{ config, lib, pkgs, ... }
{
  networking.firewall.allowedTCPPorts = [ 7878 ];

  services.radarr = {
    enable = true;
    user = "radarr";
    group = "radarr";
    dataDir = "/var/lib/radarr/";
    openFirewall = true;
    settings = {
      server = {
        urlbase = "/radarr";
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
