{
  imports = [
    ./cli.nix
    ./development.nix
    ./desktop.nix
    ./gaming.nix
    ./plasma.nix
  ];

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
