# /etc/nixos/sys-modules/automount-karmen.nix
{ config, lib, pkgs, ... }:

{

  environment.systemPackages = [pkgs.cifs-utils];

  systemd.tmpfiles.rules = [ 
    "d /mnt/publicshare 0755 root root -"
  ];

  fileSystems."/mnt/publicshare" = {
    device = "//192.168.1.103/Andrew";
    fsType  = "cifs";
    options = [
      "username=Bunny"
      "password=lol"
      "_netdev"
      "nofail"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "vers=3.0"
    ];
  };
}
