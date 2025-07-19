#/etc/nixos/host/home.nix
{ config, pkgs, ... }:

{
  imports = [
    ../home-modules/fastfetch.nix
    ../home-modules/fish.nix
    ../home-modules/git.nix
    ../home-modules/kitty.nix
  ];

  home.username = "wings";
  home.homeDirectory = "/home/wings";
  home.stateVersion = "25.05"; # Do not change this after initial setup

  programs.git = {
    enable = true;
    userName = "AwkwardGecko";
    userEmail = "doomguy95@hotmail.com";
  };
}
