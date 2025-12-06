#./sys-modules/restart-clean.nix
{ config, lib, pkgs, ... }:
{
  boot.kernelParams = [ 
    # "reboot=efi"     # tested
    # "reboot=acpi"    #
    # "reboot=pci"     # 
    # "reboot=kbd"     # 
    "reboot=triple"  # 
  ];
}
