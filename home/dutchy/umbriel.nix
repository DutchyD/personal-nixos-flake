{ lib, osConfig, ... }:

{
  config = lib.mkIf (osConfig.custom.desktop == "umbriel") {
    programs.umbriel = {
      enable = true;
      settings = ./umbriel.toml;
    };

    programs.noctalia = {
      enable = true;
      settings = ./noctalia.toml;
    };
  };
}
