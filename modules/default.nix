{
  # Shared modules common to every host. Desktop environments are exposed
  # as specialisations via ./desktop-specialisations.nix.
  imports = [
    ./boot.nix
    ./core.nix
    ./locale.nix
    ./users.nix
  ];
}
