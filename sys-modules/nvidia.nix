# /etc/nixos/sys-modules/nvidia.nix
{ config, pkgs, lib, ... }:

{
  # Proprietary driver requires unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable basic OpenGL support
  hardware.graphics.enable        = true;
  hardware.graphics.extraPackages = with pkgs; [ libGL ];

  # NVIDIA proprietary driver (Optimus laptop support via PRIME offload)
  hardware.nvidia = {
    enable           = true;
    # pick the 'stable' driver set from your kernelPackages (e.g. 535 or 560 series)
    package          = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;     # load nvidia-drm for modesetting
    prime = {
      offload.enable = true;       # allow `__NV_PRIME_RENDER_OFFLOAD=1`
      sync.enable    = true;       # PRIME sync (tear-free)
    };
  };

  # Tell X11 to load the nvidia driver
  services.xserver.videoDrivers = [ "nvidia" ];
}
