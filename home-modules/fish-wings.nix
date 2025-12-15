#/etc/nixos/home-modules/wings-fish.nix
{ config, lib, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellInit = "cd ~";
    shellInitLast = "fastfetch";
    shellAbbrs = {
      "update" = "bash /etc/nixos/hosts/wings/update.sh";
    };
  };
}
