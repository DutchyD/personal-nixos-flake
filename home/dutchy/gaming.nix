{
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  config = lib.mkIf (osConfig.custom.gaming.enable && osConfig.custom.desktop != "none") {
    home.packages = with pkgs; [
      lunar-client
    ];
  };
}
