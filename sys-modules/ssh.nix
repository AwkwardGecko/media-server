# /etc/nixos/sys-modules/ssh.nix
{ config, pkgs, lib, ... }:

{
  ## 1) Enable the SSH daemon for incoming connections
  services.openssh = {
    enable                  = true;
    permitRootLogin         = "no";          # use your regular user instead of root
    passwordAuthentication  = false;         # disable passwords if you only use keys
    # authorizedKeys.keys.wings = [ "/home/yourUser/.ssh/authorized_keys" ];
  };

  ## 2) Open TCP/22 in the system firewall
  networking.firewall.allowedTCPPorts = [ 22 ];

  ## 3) (Optional) Start ssh-agent on login for outbound key management
  programs.ssh.startAgent = true;
}
