{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.seerr = {
    enable = true;
    port = 5055;
    openFirewall = true;
  };
}
