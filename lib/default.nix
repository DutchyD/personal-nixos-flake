{
  nixpkgs,
  home-manager,
  plasma-manager,
}:

let
  inherit (nixpkgs) lib;

  hostNames = lib.attrNames (
    lib.filterAttrs (_: type: type == "directory") (builtins.readDir ../hosts)
  );

  homeManagerWiring =
    { config, ... }:
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        sharedModules = [ plasma-manager.homeModules.plasma-manager ];
        users.${config.custom.user.name} = import ../home/${config.custom.user.name};
      };
    };

  mkHost =
    hostName:
    lib.nixosSystem {
      modules = [
        { networking.hostName = hostName; }
        ../hosts/${hostName}
        ../modules
        home-manager.nixosModules.home-manager
        homeManagerWiring
      ];
    };
in
lib.genAttrs hostNames mkHost
