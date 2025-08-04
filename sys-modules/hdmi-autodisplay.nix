# sys-modules/hdmi-switch.nix
{ pkgs, config, lib, ... }:

let
  script = pkgs.writeShellScriptBin "hdmi-switch" ''
    #!/usr/bin/env bash
    export DISPLAY=:0
    export QT_QPA_PLATFORM=wayland   # if on Wayland
    export XDG_RUNTIME_DIR=/run/user/$(id -u wings)
    export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus

    status=$(cat /sys/class/drm/card0-HDMI-A-1/status)
    if [[ $status == connected ]]; then
      kscreen-doctor output.eDP-1.disable \
                     output.HDMI-A-1.enable \
                     output.HDMI-A-1.primary
    else
      kscreen-doctor output.eDP-1.enable \
                     output.HDMI-A-1.disable
    fi
  '';
in {
  environment.systemPackages = [ script pkgs.kdeFrameworks.kcoreaddons ];

  # enable systemd user services
  services.systemd.user = {
    enable = true;
    services.hdmi-switch = {
      description = "Auto HDMI switch for Plasma";
      after       = [ "graphical-session.target" ];
      wantedBy    = [ "graphical-session.target" ];
      serviceConfig = {
        ExecStart = "${script}";
        Restart   = "on-failure";
      };
    };
  };
}
