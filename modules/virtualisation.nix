{ ... }:

{
  # Docker daemon. The dutchy user is added to the `docker` group in
  # users.nix so it can talk to the daemon without sudo.
  virtualisation.docker.enable = true;

  # Docker Compose v2 (the `docker compose` subcommand) ships as a plugin
  # and is included with the docker package.
}
