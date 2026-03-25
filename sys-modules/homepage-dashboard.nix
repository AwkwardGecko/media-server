{ config, lib, pkgs, ... }:
{
  services.homepage-dashboard = {
    enable = true;

    # Match what you were using for Homarr/Homepage access
    listenPort = 7575;
    openFirewall = true;

    # Fix: "Host validation failed for: 192.168.1.157:7575"
    # Add any extra hostnames you use (eg homepage.zozano.au) if you reverse proxy it.
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
          disk = [ "/" "/data" ];
        };
      }
      {
        search = {
          provider = "google";
          target = "_blank";
        };
      }
    ]; # :contentReference[oaicite:3]{index=3}

    # Sidebar-style links (bookmarks.yaml)
    bookmarks = [
      {
        "Links" = [
          { "Twitch" = [{ href = "https://www.twitch.tv/"; }]; }
          { "linuxserver.io" = [{ href = "https://www.linuxserver.io/"; }]; }
          { "Trash Guides" = [{ href = "https://trash-guides.info/"; }]; }
          { "Airsonic Apps" = [{ href = "https://airsonic.github.io/docs/apps/"; }]; }
          { "Homarr Docs" = [{ href = "https://homarr.dev/"; }]; }
        ];
      }
    ];

    # Main tiles (services.yaml)
    services = [
      { "Server" = [
        { "Jellyfin" = {
          href = "http://192.168.1.157:8096";
          icon = "jellyfin.svg";
        };}

        { "Jellyfin2" = {
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

        #{ "Lidarr" = {
          #href = "http://192.168.1.157:8686";
          #icon = "lidarr.svg";
        #};}

        { "qBittorrent" = {
          href = "http://192.168.1.157:8200";
          icon = "qbittorrent.svg";
        };}

        { "Syncthing" = {
          href = "http://192.168.1.157:8384";
          icon = "syncthing.svg";
        };}

        { "Home Assistant" = {
          href = "http://192.168.1.157:8123";
          icon = "home-assistant.svg";
        };}

        { "Tdarr" = {
          href = "http://192.168.1.157:8265";
          icon = "tdarr";
        };}

        { "Whisparr" = {
          href = "http://192.168.1.157:6969";
          icon = "whisparr";
        };}

        #{ "Deemix" = {
          #href = "http://192.168.1.157:6595";
          #icon = "deemix.svg";
        #};}

        #{ "Airsonic" = {
          #href = "http://192.168.1.157:4040";
          #icon = "airsonic.svg";
        #};}
      ];}

      { "Web" = [
        { "Router" = {
          href = "http://192.168.1.1";
          icon = "http://192.168.1.1/luci-static/bootstrap/logo.svg";
        };}

        { "YouTube" = {
          href = "https://youtube.com/";
          icon = "https://www.youtube.com/s/desktop/191847ec/img/favicon_144x144.png";
        };}

        { "Outlook" = {
          href = "https://outlook.live.com/";
          icon = "https://res.public.onecdn.static.microsoft/assets/mail/pwa/v4/pngs/apple-touch-icon.png";
        };}

        { "Proton Mail" = {
          href = "https://mail.proton.me/";
          icon = "https://mail.proton.me/assets/apple-touch-icon-180x180.png";
        };}

        { "Proton Calendar" = {
          href = "https://calendar.proton.me/";
          icon = "https://calendar.proton.me/assets/apple-touch-icon-180x180.png";
        };}

        { "Proton Drive" = {
          href = "https://drive.proton.me/";
          icon = "https://drive.proton.me/assets/apple-touch-icon-180x180.png";
        };}

        { "Proton Pass" = {
          href = "https://pass.proton.me/";
          icon = "https://pass.proton.me/assets/apple-touch-icon-180x180.png";
        };}

        { "OneNote" = {
          href = "https://onedrive.live.com/personal/F4121818BFD311DE/_layouts/15/Doc.aspx?sourcedoc={d427d9c6-39f6-43ef-a8c7-5ae467056c56}&action=edit&wd=target%282.0%20New%20Topics.one%7C40085077-af4b-458a-b958-2e892919265f%2F0%20Overview%7C923989b8-612d-4862-8a06-c0fb69614d62%2F%29&wdorigin=NavigationUrl";
          icon = "https://res.public.onecdn.static.microsoft/officeonline/o/s/h4C52A028B840791A_resources/1033/FavIcon_OneNote.ico";
        };}

        { "Bank Australia" = {
          href = "https://www.bankaust.com.au/";
          icon = "https://cdn.prod.website-files.com/64d5d5beb2a67e9491ecdff8/64d5d5beb2a67e9491ece3e2_favicon-256x256--a9039ba4fc05dc7253af9d6d53c8706e.jpg";
        };}

      ];}

      { "Star Rail" = [
        { "Prydwen" = {
          href = "https://www.prydwen.gg/";
          icon = "https://www.prydwen.gg/icons/icon-512x512.png";
        };}

        { "Interactive Map" = {
          href = "https://star-rail-map.appsample.com/";
          icon = "https://star-rail-map.appsample.com/favicon.ico";
        };}

        { "Warp Tracker" = {
          href = "https://starrailstation.com/en/warp#char_event";
          icon = "https://starrailstation.com/apple-touch-icon.png";
        };}

        { "Achievements" = {
          href = "https://stardb.gg/en/achievement-tracker";
          icon = "https://stardb.gg/favicon.png";
        };}

        { "Star Rail Spreadsheet" = {
          href = "https://docs.google.com/spreadsheets/d/1wG5RYn3BVDoyJab4yiXl-OM7qEDiMIpN/edit?gid=1052489323#gid=1052489323";
        };}

        { "Relic Scorer" = {
          href = "https://fribbels.github.io/hsr-optimizer/";
        };}

        { "Ascension Planner" = {
          href = "https://starrail.mobilemeta.gg/tool/character-ascension-planner";
        };}
      ];}
    ]; # :contentReference[oaicite:5]{index=5}
  };
}
