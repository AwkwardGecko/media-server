#/etc/nixos/home-modules/fish-brock.nix
{ config, lib, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellInit = "cd ~";
    shellInitLast = "fastfetch";
    shellAbbrs = {
      "update" = "bash /etc/nixos/hosts/brock/update.sh";
    };
    functions.fish_greeting = "";
  };
}
