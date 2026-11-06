{ config, lib, ... }:

{
  config = lib.mkIf (config.custom.desktop == "umbriel") {
    programs.umbriel.enable = true;

    services.displayManager.noctalia-greeter.enable = true;
  };
}
