{
  imports = [ ./hardware-configuration.nix ];

  services.spice-vdagentd.enable = true;

  custom = {
    development.enable = true;
    docker.enable = true;
  };

  system.stateVersion = "26.05";
}
