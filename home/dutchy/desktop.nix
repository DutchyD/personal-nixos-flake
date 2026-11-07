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
        commandLineArgs = "--password-store=kwallet6";
      })
      firefox
      google-chrome
      discord
      spotify
      ghostty
    ];
  };
}
