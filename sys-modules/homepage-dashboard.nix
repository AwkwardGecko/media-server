{ config, lib, pkgs, ... }:
{
  services.homepage-dashboard = {
    enable = true;
    listenPort = 7575;
    openFirewall = true;
    allowedHosts = "192.168.1.157:7575,localhost:7575,127.0.0.1:7575";

    settings = {
      title = "Home";
      theme = "dark";
      color = "neutral";
      headerStyle = "boxed";
    };

    widgets = [
      {
        resources = {
          cpu = true;
          memory = true;
          disk = [ "/" ];
        };
      }
      {
        search = {
          provider = "google";
          target = "_blank";
        };
      }
    ];

    services = [
      { "Server" = [
        { "Jellyfin Web" = {
          href = "http://192.168.1.157:8096";
          icon = "jellyfin.svg";
        };}
        { "Jellyfin App" = {
          href = "jmp://open";
          icon = "jellyfin.svg";
        };}
        { "Jellyseerr" = {
          href = "http://192.168.1.157:5055";
          icon = "jellyseerr.svg";
        };}
        { "Sonarr" = {
          href = "http://192.168.1.157:8989";
          icon = "sonarr.svg";
        };}
        { "Radarr" = {
          href = "http://192.168.1.157:7878";
          icon = "radarr.svg";
        };}
        { "Prowlarr" = {
          href = "http://192.168.1.157:9696";
          icon = "prowlarr.svg";
        };}
        { "Bazarr" = {
          href = "http://192.168.1.157:6767";
          icon = "bazarr.svg";
        };}
        { "qBittorrent" = {
          href = "http://192.168.1.157:8200";
          icon = "qbittorrent.svg";
        };}
      ];}
      { "Web" = [
        { "YouTube" = {
          href = "https://youtube.com/";
          icon = "https://www.youtube.com/s/desktop/191847ec/img/favicon_144x144.png";
        };}
      ];}
    ];
  };
}
