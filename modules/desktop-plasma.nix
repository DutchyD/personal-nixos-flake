{ ... }:

{
  # KDE Plasma 6 desktop. Pulls in the shared display-manager/audio stack.
  # Import this alongside ./desktop.nix to make both selectable at the SDDM
  # login screen.
  imports = [ ./desktop-common.nix ];

  services.desktopManager.plasma6.enable = true;
}
