{ config, lib, pkgs, ... }:
{
  services.homepage-dashboard = {
    enable = true;

    # Match what you were using for Homarr/Homepage access
    listenPort = 7575;
    openFirewall = true;

    # Fix: "Host validation failed for: 192.168.1.157:7575"
    allowedHosts = "192.168.1.157:7575,localhost:7575,127.0.0.1:7575";

    # Homepage UI settings (settings.yaml)
    # (These are Homepage's own config keys; NixOS writes the yaml for you.)
    settings = {
      title = "Home";
      theme = "dark";
      color = "neutral";
      headerStyle = "boxed";
    }; # :contentReference[oaicite:2]{index=2}

    # Top widgets (widgets.yaml)
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
    ]; # :contentReference[oaicite:3]{index=3}

    # Main tiles (services.yaml)
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



    ];
  };
}
