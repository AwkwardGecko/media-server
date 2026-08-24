{ config, lib, pkgs, ... }:
{
  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    group = "media";
    torrentingPort = 18757;
    webuiPort      = 8200;
    
    serverConfig = {
      LegalNotice.Accepted = true;
      #UMask = 0002;
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

      Core.AutoDeleteAddedTorrentFile = "Never";
    };
  };
}
