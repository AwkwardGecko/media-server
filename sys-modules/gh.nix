#/etc/nixos/sys-modules/gh.nix
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gh
  ];
}
