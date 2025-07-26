# /etc/nixos/sys-modules/automount-karmen.nix
{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/Karmen" = {
    device = "//192.168.1.105/Andrew";
    fsType  = "cifs";
    options = [
      "credentials=/etc/nixos/secrets/andrew.creds"   # username=Bunny / password=lol
      "uid=${toString config.users.users.wings.uid}"  # or hard‑code 1000
      "gid=${toString config.users.users.wings.group}"# or hard‑code 100
      "vers=3.0"
      "rw"
      "_netdev"                # wait for network‑online.target
      "nofail"                 # don’t break boot if share is down
      "x-systemd.after=network-online.target"         # be explicit
      "x-systemd.requires=network-online.target"
    ];
  };
}
