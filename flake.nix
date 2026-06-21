#/etc/nixos/flake.nix
{
  description = "Media Server default flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    
    flake-parts.url = "github:hercules-ci/flake-parts";
    #flake-parts.inputs.nixpkgs.follows = "nixpkgs";
    
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, flake-parts, ... }:
  flake-parts.lib.mkFlake { inherit inputs; } {
    systems = [ "x86_64-linux" ];
    imports = [
      ./hosts/wings/flake-part.nix
      ./hosts/ranon/flake-part.nix
      ./hosts/brock/flake-part.nix
    ];

    perSystem = { config, self', inputs', pkgs, system, ... }: {
      formatter = pkgs.nixpkgs-fmt;

      packages = {
        remotemouse = pkgs.callPackage ./remotemouse {
          glib = pkgs.glib;
          dbus = pkgs.dbus;
          zlib = pkgs.zlib;
          freetype = pkgs.freetype;
          fontconfig = pkgs.fontconfig;
          libxkbcommon = pkgs.libxkbcommon;
          libGL = pkgs.libGL;
          alsa-lib = pkgs.alsa-lib;
          xorg = pkgs.xorg;
          xdotool = pkgs.xdotool;
        };
        default = self'.packages.remotemouse;
      };
    };
  };
}
