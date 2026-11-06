{ lib, ... }:

{
  imports = [
    ./graphical.nix
    ./plasma.nix
    ./umbriel.nix
  ];

  options.custom.desktop = lib.mkOption {
    type = lib.types.enum [
      "plasma"
      "umbriel"
      "none"
    ];
    default = "plasma";
    description = "Desktop environment of this boot entry. Only specialisations should set it.";
  };
}
