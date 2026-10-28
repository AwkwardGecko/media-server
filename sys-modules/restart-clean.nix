#./sys-modules/restart-clean.nix
{ config, lib, pkgs, ... }:
{
  boot.kernelParams = [
    # # (no explicit kernelParam set)
    # "reboot=efi"     #
    # "reboot=acpi"    #
    # "reboot=pci"       # tested 2026-10-28
    # "reboot=kbd"     #
    # "reboot=triple"  #
  ];

  boot.blacklistedKernelModules = [
    # Prevent the watchdog from being armed at all, since intel_oc_wdt
    # on this board doesn't appear to stop cleanly during shutdown.
    "intel_oc_wdt"

    # Test whether Nouveau is hanging the final kernel power-off/reboot
    # handoff on the Aspire E5-771G. The internal display uses Intel
    # graphics, and this media server does not need the GeForce 840M.
    "nouveau"
  ];

  # Belt-and-suspenders: also tell systemd not to re-arm it as a
  # shutdown fallback even if something else loads the module.
  systemd.settings.Manager.ShutdownWatchdogSec = "off";
}
