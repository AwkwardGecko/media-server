# sys-modules/hdmi-autodisplay.nix
{ lib, pkgs, config, ... }:

let
  internal = "eDP-1";         # adjust with `kscreen-doctor -o`
  external = "HDMI-A-1";

  script = pkgs.writeShellScript "hdmi-switch" ''
    #!${pkgs.bash}/bin/bash
    user="wings"
    uid=$(id -u "$user")

    export XDG_RUNTIME_DIR="/run/user/$uid"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
    export DISPLAY=":0"

    status=$(cat /sys/class/drm/card0-${external}/status)

    if [[ "$status" == "connected" ]]; then
      ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor \
        output.${internal}.disable \
        output.${external}.enable \
        output.${external}.primary
    else
      ${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor \
        output.${internal}.enable \
        output.${external}.disable
    fi
  '';
in
{
  environment.systemPackages = [
    pkgs.kdePackages.libkscreen  # handy on $PATH for debugging
    script
  ];

  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", \
      RUN+="${script}"
  '';
}
