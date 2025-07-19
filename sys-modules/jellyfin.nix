#/etc/nixos/sys-modules/jellyfin.nix
{ pkgs, lib, config, ... }:
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
    user = "wings";
  };

  environment.systemPackages = with pkgs; [
    chromaprint
    jellyfin
    jellyfin-ffmpeg
  ];
}
