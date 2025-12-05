#/etc/nixos/sys-modules/bazarr.nix
{ config, lib, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [ 6767 ];

  systemd.services.bazarr.serviceConfig.UMask = "0002";

  services.bazarr = {
    enable = true;
    user = "bazarr";
    group = "media";
    listenPort = 6767;
    openFirewall = true;
  };
}
