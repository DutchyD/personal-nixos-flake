{ pkgs, ... }:

{
  # Hyprland desktop. Pulls in the shared display-manager/audio stack.
  imports = [ ./desktop-common.nix ];

  programs.hyprland.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  services.displayManager.defaultSession = "hyprland";

  # Hyprland-specific tooling. Only installed on hosts that enable Hyprland.
  environment.systemPackages = [ pkgs.hyprlauncher ];
}
