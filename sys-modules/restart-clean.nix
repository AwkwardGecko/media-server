#./sys-modules/restart-clean.nix
{ config, lib, pkgs, ... }:
{
  boot.kernelParams = [ 
    # "reboot=efi"     # tested
    # "reboot=acpi"    # tested
    # "reboot=pci"     # tested
    "reboot=kbd"     #
    # "reboot=triple"  #
  ];
}
