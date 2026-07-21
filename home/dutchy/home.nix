{ config, pkgs, ... }:

{
  home.username = "dutchy";
  home.homeDirectory = "/home/dutchy";

  # Like system.stateVersion: leave at the release of first install.
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  programs.gh.enable = true;
  
  # git is provided system-wide (modules/core.nix) and gh via programs.gh above.
  home.packages = with pkgs; [
    dotnet-sdk_10
    jdk25
    nodejs
    bun
    pnpm

    claude-code
    jetbrains-toolbox
    (vivaldi.override {
      proprietaryCodecs = false;
      enableWidevine = true;
    })
    firefox
    google-chrome
    discord
    spotify
    krusader
    kdePackages.kate
    ghostty
    kdePackages.dolphin
    kdiff3
    krename
    lunar-client
  ];
}
