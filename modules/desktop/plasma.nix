{ config, lib, ... }:

{
  config = lib.mkIf (config.custom.desktop == "plasma") {
    services.desktopManager.plasma6.enable = true;

    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
  };
}
