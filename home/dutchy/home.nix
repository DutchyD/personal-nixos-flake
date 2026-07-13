{ config, pkgs, ... }:

{
  home.username = "dutchy";
  home.homeDirectory = "/home/dutchy";

  # Like system.stateVersion: leave at the release of first install.
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.kitty.enable = true;
  programs.gh.enable = true;
  
  home.packages = with pkgs; [
    claude-code
    jetbrains-toolbox
    vivaldi
    ghostty
    hyprlauncher
    kdePackages.dolphin
  ];
  
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "ghostty"; # Or your preferred terminal emulator
        layer = "overlay";
        lines = 10;
        width = 30;
        font = "monospace:size=12";
      };
      colors = {
        background = "282a36ff";
        text = "f8f8f2ff";
        match = "8be9fdff";
        selection = "44475aff";
        selection-text = "f8f8f2ff";
        border = "bd93f9ff";
      };
    };
  };
}
