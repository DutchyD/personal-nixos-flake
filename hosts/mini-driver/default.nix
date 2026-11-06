{
  imports = [ ./hardware-configuration.nix ];

  custom = {
    development.enable = true;
    docker.enable = true;
    gaming.enable = true;
    nixLd.enable = true;
  };

  specialisation.umbriel.configuration.custom.desktop = "umbriel";

  system.stateVersion = "26.05";
}
