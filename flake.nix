{
  description = "NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    umbriel = {
      url = "github:noctalia-dev/umbriel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      plasma-manager,
      umbriel,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      nixosConfigurations = import ./lib {
        inherit
          nixpkgs
          home-manager
          plasma-manager
          umbriel
          ;
      };
    in
    {
      inherit nixosConfigurations;

      devShells.${system} = import ./shells { inherit pkgs; };

      formatter.${system} = pkgs.nixfmt-tree;

      checks.${system} = import ./lib/checks.nix {
        inherit pkgs nixosConfigurations;
        source = ./.;
      };
    };
}
