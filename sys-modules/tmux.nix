{ config, lib, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-shell ${pkgs.fish}/bin/fish
      set -g default-command ${pkgs.fish}/bin/fish
    '';
  };
}
