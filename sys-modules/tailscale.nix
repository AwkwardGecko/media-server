# /etc/nixos/sys-modules/tailscale.nix
{ config, pkgs, lib, ... }:

let
  # Path on the client where you will copy the pre-auth key
  hsKeyPath = "/etc/tailscale/hskey.txt";
in
{
  ## Copy the key into the immutable Nix store at build time.
  ## Replace the source with wherever you actually stash the key.
  environment.etc."tailscale/hskey.txt".source = "/root/.secrets/hskey.txt";

  services.tailscale = {
    enable               = true;
    openFirewall         = true;        # punches UDP/41641 etc.
    authKeyFile          = hsKeyPath;   # Headscale pre-auth key
    useRoutingFeatures   = "client";    # you are not an exit node
    extraUpFlags         = [
      "--login-server=https://headscale.dectech.au"
      "--accept-dns=true"               # switch to false if you want local DNS
    ];
    # tailscaled-autoconnect will pick up the flags on boot
  };
}
