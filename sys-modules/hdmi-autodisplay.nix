# sys-modules/hdmi-switch.nix
{ config, pkgs, ... }:

let
  script = pkgs.writeShellScriptBin "hdmi-switch" ''
    #!/usr/bin/env bash
    export QT_QPA_PLATFORM=wayland           # drop this line if you force X11
    export XDG_RUNTIME_DIR=/run/user/$(id -u wings)
    export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus

    status=$(cat /sys/class/drm/card0-HDMI-A-1/status)

    if [[ $status == connected ]]; then
      ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor \
        output.eDP-1.disable \
        output.HDMI-A-1.enable \
        output.HDMI-A-1.primary
    else
      ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor \
        output.eDP-1.enable \
        output.HDMI-A-1.disable
    fi
  '';
in
{
  environment.systemPackages = [
    pkgs.kdePackages.libkscreen
    script
  ];

  systemd.user.services.hdmi-switch = {
    description  = "Auto-select HDMI and disable laptop panel";
    after        = [ "graphical-session.target" ];
    wantedBy     = [ "graphical-session.target" ];
    serviceConfig = {
      Type      = "oneshot";
      ExecStart = "${script}/bin/hdmi-switch";
    };
  };
}
