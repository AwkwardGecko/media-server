{ config, lib, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [
    8686
  ];

services.lidarr = {
    enable = true;
    user = "lidarr";
    group = "media";
    dataDir = "/var/lib/lidarr/";
    openFirewall = true;
    settings = {
      server = {
        urlbase = "/lidarr";
        port = 8686;
        bindaddress = "*";
      };
    };
  };
}
