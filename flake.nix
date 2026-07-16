{
  description = "Dylan's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      # Shared home-manager wiring for the dutchy user.
      homeManager = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.dutchy = import ./home/dutchy/home.nix;
      };

      # no `system` arg — each host's hardware-configuration.nix sets
      # nixpkgs.hostPlatform.
      mkHost = hostModule: nixpkgs.lib.nixosSystem {
        modules = [
          hostModule
          home-manager.nixosModules.home-manager
          homeManager
        ];
      };
    in
    {
      nixosConfigurations = {
        nixos = mkHost ./hosts/nixos;
        dev-mini = mkHost ./hosts/dev-mini;
      };
    };
}
