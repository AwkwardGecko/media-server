#/etc/nixos/home-modules/fish-ranon.nix
{ config, lib, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellInit = "cd ~";
    shellInitLast = "fastfetch";
    shellAbbrs = {
      "update" = "bash /etc/nixos/hosts/ranon/update.sh";
    };
  };
}
