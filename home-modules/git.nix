#/etc/nixos/modules/git.nix
{ config, lib, pkgs, ... }:
{
	programs.git = {
		enable = true;
		settings.user = {
			name = "AwkwardGecko";
			email = "doomguy95@hotmail.com";
		};
	};
}
