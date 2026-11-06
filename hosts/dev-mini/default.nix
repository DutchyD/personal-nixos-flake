{
  imports = [ ./hardware-configuration.nix ];

  custom = {
    development.enable = true;
    docker.enable = true;
    gaming.enable = true;
    nixLd.enable = true;
  };

  system.stateVersion = "26.05";
}
