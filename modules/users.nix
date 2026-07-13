{ ... }:

{
  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.dutchy = {
    isNormalUser = true;
    description = "Dylan de Beer";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
