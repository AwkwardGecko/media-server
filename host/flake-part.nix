#/etc/nixos/host/flake-part.nix
{ inputs, ... }:
{
  flake.nixosConfigurations.wings = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit (inputs) host; };

    modules = [
      { nixpkgs.config.allowUnfree = true; }
      ./configuration.nix
      inputs.nixvim.nixosModules.nixvim
      inputs.home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          users.wings = import ./home.nix;
        };
      }
    ];
  };
}
