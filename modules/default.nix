{
  # Shared modules common to every host. Desktop environments are chosen
  # per-host (import ./desktop.nix and/or ./desktop-plasma.nix).
  imports = [
    ./boot.nix
    ./core.nix
    ./locale.nix
    ./users.nix
  ];
}
