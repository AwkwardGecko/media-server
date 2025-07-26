#/etc/nixos/modules/git.nix
{ config, lib, pkgs, ... }:
{
	programs.git = {
		enable = true;
		userName = "AwkwardGecko";
		userEmail = "doomguy95@hotmail.com";
	};
}
