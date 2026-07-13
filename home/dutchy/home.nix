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
  ];
}
