# /etc/nixos/sys-modules/ssh.nix
{ config, pkgs, lib, ... }:
{
  ## 1) Enable the SSH daemon for incoming connections
  services.openssh = {
    enable                  = true;
  };

  ## 2) Open TCP/22 in the system firewall
  networking.firewall.allowedTCPPorts = [ 22 ];

  ## 3) (Optional) Start ssh-agent on login for outbound key management
  programs.ssh.startAgent = true;
}
