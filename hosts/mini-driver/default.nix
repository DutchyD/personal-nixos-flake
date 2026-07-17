{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../modules/desktop-specialisations.nix
  ];

  networking.hostName = "mini-driver";

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Leave it at the release
  # version of the first install of this system.
  system.stateVersion = "26.05";
}
