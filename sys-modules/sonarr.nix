#/etc/nixos/sys-modules/sonarr.nix
{ config, lib, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 8989 ];

  systemd.services.sonarr.serviceConfig.UMask = "0002";

  services.sonarr = {
    enable = true;
    user = "sonarr";
    group = "media";
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
