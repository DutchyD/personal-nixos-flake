{
  lib,
  pkgs,
  osConfig,
  ...
}:

{
  config = lib.mkIf (osConfig.custom.desktop != "none") {
    home.packages = with pkgs; [
      jetbrains-toolbox
      (vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
      })
      firefox
      google-chrome
      discord
      spotify
      ghostty
    ];
  };
}
