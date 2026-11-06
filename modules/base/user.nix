{ config, lib, ... }:

{
  options.custom.user.name = lib.mkOption {
    type = lib.types.str;
    default = "dutchy";
    description = "Login name of the primary user.";
  };

  config.users.users.${config.custom.user.name} = {
    isNormalUser = true;
    description = "Dylan de Beer";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
