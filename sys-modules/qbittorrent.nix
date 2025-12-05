{ config, lib, pkgs, ... }:
{
  systemd.services.qittorrent.serviceConfig.UMask = "0002";

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    group = "media";
    torrentingPort = 18757;
    webuiPort      = 8200;
    
    serverConfig = {
      LegalNotice.Accepted = true;
      BitTorrent = {
        Session = {
          DefaultSavePath = "/media/downloads";
          TempPath        = "/media/downloads/incomplete";
          TempPathEnabled = true;
          Port             = 18757;
          SSL.Port         = 12950;
          QueueingSystemEnabled = false;
          ShareLimitAction      = "Stop";
        };
      };

      Preferences = {
        Connection = {
          PortRangeMin = 6881;
          UPnP         = false;
        };

        Downloads = {
          SavePath = "/media/downloads";
          TempPath = "/media/downloads/incomplete";
        };

        General.Locale = "en";

        WebUI = {
          Address                    = "*";
          Port                       = 8200;
          ServerDomains              = "*";
          AuthSubnetWhitelist        = "192.168.1.0/24";
          AuthSubnetWhitelistEnabled = true;
          LocalHostAuth              = false;

          CustomHTTPHeadersEnabled = false;
          CustomHTTPHeaders =
            "content-security-policy: default-src 'self'; \
             style-src 'self' 'unsafe-inline' theme-park.dev raw.githubusercontent.com use.fontawesome.com; \
             img-src 'self' theme-park.dev raw.githubusercontent.com data:; \
             script-src 'self' 'unsafe-inline'; \
             object-src 'none'; \
             form-action 'self'; \
             frame-ancestors 'self'; \
             font-src use.fontawesome.com;";
        };
      };

      Network = {
        PortForwardingEnabled = true;
        Proxy = {
          HostnameLookupEnabled = false;
          Profiles = {
            BitTorrent = true;
            Misc       = true;
            RSS        = true;
          };
        };
      };

      RSS.AutoDownloader = {
        DownloadRepacks    = true;
        SmartEpisodeFilter =
          ''s(\\d+)e(\\d+), (\\d+)x(\\d+), "(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})", "(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})"'';
      };

      Core.AutoDeleteAddedTorrentFile = "Never";
    };
  };
}
