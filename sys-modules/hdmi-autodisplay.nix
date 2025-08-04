#/etc/nixos/sys-modules/hdmi-autodisplay.nix
{ lib, pkgs, config, ... }:

let
  # Replace these with the exact connector names shown by `kscreen-doctor -o`
  internal = "eDP-1";
  external = "HDMI-A-1";

  script = pkgs.writeShellScript "hdmi-switch" ''
    #!${pkgs.bash}/bin/bash
    user="wings"                                # your login user
    uid=$(id -u "$user")

    # Wayland session env vars so kscreen-doctor can talk to KWin
    export XDG_RUNTIME_DIR="/run/user/$uid"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
    export DISPLAY=":0"                       # harmless on Wayland

    status=$(cat /sys/class/drm/card0-${external}/status)

    if [[ "$status" == "connected" ]]; then
      ${pkgs.plasma-workspace}/bin/kscreen-doctor \
        output.${internal}.disable \
        output.${external}.enable \
        output.${external}.primary
    else
      ${pkgs.plasma-workspace}/bin/kscreen-doctor \
        output.${internal}.enable \
        output.${external}.disable
    fi
  '';
in
{
  # Ship the script
  environment.systemPackages = [ script ];

  # Fire it on every hot-plug
  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", ENV{HOTPLUG}=="1", \
      RUN+="${script}"
  '';
}
