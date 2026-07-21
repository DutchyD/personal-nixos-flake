{ ... }:

{
  # Shared graphics, display-manager and audio stack for any GUI host.
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;

  programs.steam.enable = true;

  # Bluetooth. Plasma 6 ships the bluedevil GUI applet automatically, so
  # enabling the BlueZ stack here is all that's needed. powerOnBoot brings
  # the adapter up at startup.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
