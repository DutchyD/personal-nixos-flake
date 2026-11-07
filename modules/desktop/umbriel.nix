{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.custom.desktop == "umbriel") {
    programs.umbriel.enable = true;

    services.displayManager.noctalia-greeter.enable = true;

    environment.systemPackages = [ pkgs.kitty ];
  };
}
