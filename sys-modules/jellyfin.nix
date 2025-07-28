#/etc/nixos/sys-modules/jellyfin.nix
{ pkgs, lib, config, ... }:
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
    settings = {
      "FFmpeg:vaapi" = "true"; # VA-API decode/encode
      "VideoEncoder:EnableQsv" = "true";
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [ intel-vaapi-driver libva ];
  };

  environment.systemPackages = with pkgs; [
    #ffmpegNVENC
    chromaprint
    jellyfin
    jellyfin-ffmpeg
    vlc
  ];
}
