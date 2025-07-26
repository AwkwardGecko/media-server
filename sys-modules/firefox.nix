#/etc/nixos/sys-modules/firefox.nix
{ config, lib, pkgs, ... }:
{
  programs.firefox.enable = true;
}
