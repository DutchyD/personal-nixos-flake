{ config, lib, ... }:

{
  options.custom.docker.enable = lib.mkEnableOption "the Docker daemon for the primary user";

  config = lib.mkIf config.custom.docker.enable {
    virtualisation.docker.enable = true;

    users.users.${config.custom.user.name}.extraGroups = [ "docker" ];

    networking.firewall.trustedInterfaces = [
      "docker0"
      "br-+"
    ];
  };
}
