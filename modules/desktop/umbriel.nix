{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.custom.desktop == "umbriel") {
    programs.umbriel.enable = true;

    programs.noctalia = {
      enable = true;
      recommendedServices.enable = true;
    };

    services.displayManager.noctalia-greeter.enable = true;

    environment.systemPackages = [ pkgs.kitty ];
  };
}
