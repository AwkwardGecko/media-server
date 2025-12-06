#~/.dotfiles/modules/plasma.nix
{ config, lib, pkgs, ... }:
{
  services = {
    xserver.enable = true;
    displayManager = {
      sddm.enable = true;
      sddm.wayland.enable = false;
      defaultSession = "plasmax11";
      # defaultSession = "plasmawayland"
      autoLogin = {
        enable = true;
        user = "wings";
      };
    };
    desktopManager.plasma6.enable = true;
  };
}
