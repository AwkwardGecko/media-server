#/etc/nixos/sys-modules/netbird.nix
{ config, lib, pkgs, ... }:
{
  services.netbird = {
    enable = true;



  };
}
