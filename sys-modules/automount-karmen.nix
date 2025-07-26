# /etc/nixos/sys-modules/automount-karmen.nix
{ config, lib, pkgs, ... }:

{
  fileSystems."/mnt/Karmen" = {
    device = "//192.168.1.105/Andrew";
    fsType = "cifs";

    # Automount on first access, unmount after 10 min idle
    options = [
      "credentials=/etc/nixos/secrets/andrew.creds"  # username=Bunny / password=lol
      "uid=${toString config.users.users.wings.uid}" # or hard‑code 1000 if you’re lazy
      "gid=${toString config.users.users.wings.group}" # typically 100
      "vers=3.0"
      "rw"
      "_netdev"               # wait for network
      "nofail"
      "noauto"                # don’t mount at boot
      "x-systemd.automount"   # create *.automount unit
      "x-systemd.idle-timeout=600" # 10‑minute idle unmount
    ];
  };
}
