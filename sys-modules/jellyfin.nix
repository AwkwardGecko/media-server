#/etc/nixos/sys-modules/jellyfin.nix
{ pkgs, lib, config, ... }:
let
  # Build FFmpeg with NVENC support; allow unfree so the proprietary NVENC bits can be used
  ffmpegNVENC = pkgs.ffmpeg.override {
    enableNVENC = true;
  };
in
{
  networking.firewall.allowedTCPPorts = [
    8096
    8920
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    logDir = "/var/lib/jellyfin/log";
    cacheDir = "/var/lib/jellyfin/cache";
    dataDir = "/var/lib/jellyfin/data";
    configDir = "/var/lib/jellyfin";
    user = "jellyfin";
  };

  package = pkgs.jellyfin.overrise {
    ffmpeg = ffmpegNVENC;
  };

  environment.systemPackages = with pkgs; [
    ffmpegNVENC
    chromaprint
    jellyfin
    jellyfin-ffmpeg
  ];
}
