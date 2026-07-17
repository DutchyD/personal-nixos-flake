{
  specialisation = {
    plasma.configuration = {
      imports = [ ./desktop-plasma.nix ];
    };
    hyprland.configuration = {
      imports = [ ./desktop.nix ];
    };
  };
}
