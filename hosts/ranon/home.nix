#/etc/nixos/hosts/ranon/home.nix
{ config, pkgs, ... }:

{
  imports = [
    ../../home-modules/fastfetch.nix
    ../../home-modules/fish.nix
    ../../home-modules/git.nix
    ../../home-modules/kitty.nix
  ];

  home.username = "ranon";
  home.homeDirectory = "/home/ranon";
  home.stateVersion = "25.05"; # Do not change this after initial setup

  programs.git = {
    enable = true;
    settings.user = {
      name = "AwkwardGecko";
      email = "ranon@hotmail.com";
    };
  };
}
