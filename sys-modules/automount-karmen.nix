#/etc/nixos/sys-modules/automount-karmen.nix
{ config, lib, pkgs, ... }:
{
{
  fileSystems."/mnt/Karmen" = {
    device = "//192.168.1.105/Andrew";
    fsType = "cifs";
    options = [
      "credentials=/etc/nixos/secrets/andrew.creds"
      "uid=1000"          # replace with your user’s UID
      "gid=100"           # likely your users group
      "vers=3.0"
      "rw"
    ];
  };
}
