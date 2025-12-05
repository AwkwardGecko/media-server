#/etc/nixos/sys-modules/bazarr.nix
{
  config,
  pkgs,
  lib,
  ...
}: {

  networking.firewall.allowedTCPPorts = [
    6767
  ];

  services.bazarr = {
    enable = true;
    user = "bazarr";
    group = "media";
    listenPort = 6767;
    openFirewall = true;
  };
}
