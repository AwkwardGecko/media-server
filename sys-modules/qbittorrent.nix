{ config, lib, pkgs, ... }:
{
  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    torrentingPort = 18757;
    webuiPort = 8200;
    user = "wings";
    group = "users";
    serverConfig = {
      LegalNotice.Accepted = true;
      BitTorrent = {
        DefaultSavePath = "/media/downloads";
        TempPath = "/media/downloads/incomplete";
        TempPathEnabled = true;

        MaxActiveDownloads = 100;
        MaxActiveTorrents = 100;
        MaxActiveUploads = 100;
        MaxUploads = 16;
        MaxUploadsPerTorrent = 16;
        QueueingSystemEnabled = false;

        Port = 18757;
        ShareLimitAction = "Stop";

        SSL = {
          Port = 12950;
        };
      };
    };
    Preferences = {
      Connection = {
        PortRangeMin = 6881;
        UPnP = false;
      };
      Downloads = {
        SavePath = "/media/downloads";
        TempPath = "/media/downloads/incomplete";
      };
      General.Locale = "en";
      WebUI = {
        Address = "*";
        Port = 8200;
        ServerDomains = "*";

        AuthSubnetWhitelist = "192.168.1.0/24";
        AuthSubnetWhitelistEnabled = true;
        LocalHostAuth = false;
      };
      Network = {
        PortForwardingEnabled = true;

        Proxy = {
          HostnameLookupEnabled = false;
          Profiles = {
            BitTorrent = true;
            Misc = true;
            RSS = true;
          };
        };
      };
      RSS = {
        AutoDownloader = {
          DownloadRepacks = true;
          SmartEpisodeFilter =
            ''s(\\d+)e(\\d+), (\\d+)x(\\d+), "(\\d{4}[.\\-]\\d{1,2}[.\\-]\\d{1,2})", "(\\d{1,2}[.\\-]\\d{1,2}[.\\-]\\d{4})"'';
        };
      };
      Core.AutoDeleteAddedTorrentFile = "Never";
    };
  };
}
