#/etc/nixos/sys-modules/jellyseerr.nix
{ config, lib, pkgs, ... }:
{

  networking.firewall.allowedTCPPorts = [
    5055
  ];

  services.jellyseerr = {
    enable = true;
    port = 5055;
    openFirewall = true;
    configDir = "/var/lib/jellyseerr/config";
    package = pkgs.jellyseerr; # use the unstable package if stable is not up-to-date
  };
}
