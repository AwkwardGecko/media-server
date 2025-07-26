#/etc/nixos/sys-modules/cifs-utils.nix
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    cifs-utils
  ];
}
