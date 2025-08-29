#./sys-modules/restart-clean.nix
{ config, lib, pkgs, ... }:
{
  # boot.kernelParams = [ 
    "reboot=efi"
  ];
}


    # "reboot=acpi"    # tested
    # "reboot=pci"     #
    # "reboot=kbd"     #
    # "reboot=triple"  #
