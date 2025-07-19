#/etc/nixos/home-modules/fastfetch.nix
{ config, lib, pkgs, ... }:
{
  programs.fastfetch.enable = true;
}
