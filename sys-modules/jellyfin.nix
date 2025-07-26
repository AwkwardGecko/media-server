#/etc/nixos/sys-modules/jellyfin.nix
{ pkgs, lib, config, ... }:
let
  ffmpegNvenc = pkgs.ffmpeg-full;
in
{
  nixpkgs.config.allowUnfree = true;

  networking.firewall.allowedTCPPorts = [
    8096
    8920
  ];

  users.users.jellyfin.extraGroups = [ "video" "render" ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    logDir = "/var/lib/jellyfin/log";
    cacheDir = "/var/lib/jellyfin/cache";
    dataDir = "/var/lib/jellyfin/data";
    configDir = "/var/lib/jellyfin";
    user = "jellyfin";
    ffmpegPackage = ffmpegNvenc;
  };

  environment.systemPackages = with pkgs; [
    #ffmpegNVENC
    chromaprint
    jellyfin
    jellyfin-ffmpeg
  ];
}
