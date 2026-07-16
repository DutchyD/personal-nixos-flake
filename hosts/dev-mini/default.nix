{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules
    ../../modules/desktop-plasma.nix # KDE Plasma 6
  ];

  networking = {
    hostName = "dev-mini";

    # Force reliable public upstream DNS instead of whatever DHCP hands out.
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
    networkmanager.wifi.backend = "iwd";
  };

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSSEC = "true";
      Domains = [ "~." ];
    };
  };

  # This machine can't persist EFI variables, so install limine as removable.
  boot.loader.limine.efiInstallAsRemovable = true;
  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  # Development host: enable Docker and add dutchy to the docker group
  # (merges with the base groups defined in modules/users.nix).
  virtualisation.docker.enable = true;
  users.users.dutchy.extraGroups = [ "docker" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data were taken. Leave it at the release
  # version of the first install of this system.
  system.stateVersion = "26.05";
}
