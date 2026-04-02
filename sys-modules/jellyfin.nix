#/etc/nixos/sys-modules/jellyfin.nix
{ pkgs, lib, config, ... }:
{
  nixpkgs.config.allowUnfree = true;

  #systemd.services.jellyfin.serviceConfig.UMask = "0002";


  networking.firewall.allowedTCPPorts = [
    8096
    8920
  ];

  users.users.jellyfin.extraGroups = [ "video" "render" ];
  uers.groups.media = {};

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    logDir = "/var/lib/jellyfin/log";
    cacheDir = "/var/lib/jellyfin/cache";
    dataDir = "/var/lib/jellyfin/data";
    configDir = "/var/lib/jellyfin";
    user = "jellyfin";
    group = "media";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver
      #intel-media-sdk
      libva-vdpau-driver
      intel-ocl
      libva-utils
    ];
  };

  systemd.services.jellyfin = {
    environment = {
      LIBVA_DRIVER_NAME = "i965";
      VDPAU_DRIVER = "va_gl";
    };
    serviceConfig.SupplementaryGroups = [ "video" "render" ];
  };

  nixpkgs.config.packageOverrides = pkgs: {
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { 
      enableHybridCodec = true;
    };
  };

  environment.systemPackages = with pkgs; [
    #ffmpegNVENC
    chromaprint
    libva-utils
    jellyfin
    #jellyfin-media-player
    jellyfin-ffmpeg
    vlc
  ];
}
