#/etc/nixos/hosts/brock/home.nix
{ config, pkgs, ... }:

{
  imports = [
    ../../home-modules/fastfetch.nix
    ../../home-modules/fish-brock.nix
    ../../home-modules/git.nix
    ../../home-modules/kitty.nix
  ];

  home.username = "brock";
  home.homeDirectory = "/home/brock";
  home.stateVersion = "25.11"; # Do not change this after initial setup

  programs.git = {
    enable = true;
    settings.user = {
      name = "Brock";
      email = "doomguy95@hotmail.com";
    };
  };
}
