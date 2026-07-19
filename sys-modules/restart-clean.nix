#./sys-modules/restart-clean.nix
{ config, lib, pkgs, ... }:
{
  boot.kernelParams = [ 
    # "reboot=efi"     #
    # "reboot=acpi"    #
    "reboot=pci"       #
    # "reboot=kbd"     #
    # "reboot=triple"  #
  ];

  # Prevent the watchdog from being armed at all, since intel_oc_wdt
  # on this board doesn't appear to stop cleanly during shutdown
  boot.blacklistedKernelModules = [ "intel_oc_wdt" ];

  # Belt-and-suspenders: also tell systemd not to re-arm it as a
  # shutdown fallback even if something else loads the module
  systemd.settings.Manager.ShutdownWatchdogSec = "off";
}
