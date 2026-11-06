{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.custom.gaming.enable = lib.mkEnableOption "Steam and game tooling on boot entries that have a desktop";

  config = lib.mkIf (config.custom.gaming.enable && config.custom.desktop != "none") {
    programs = {
      steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };
      gamemode.enable = true;
      gamescope.enable = true;
    };
  };
}
