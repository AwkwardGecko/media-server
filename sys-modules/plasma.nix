#~/.dotfiles/modules/plasma.nix
{ config, lib, pkgs, ... }:
{
  services = {
    xserver.enable = true;
    displayManager = {
      sddm.enable = true; 
      defaultSession = "plasma";
      # defaultSession = "plasmawayland"
      autoLogin = {
        enable = true;
        Session = "plasmax11.desktop";
        user = "wings";
      };
    };
    desktopManager.plasma6.enable = true;
  };
}
