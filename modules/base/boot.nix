{ pkgs, ... }:

{
  boot = {
    loader = {
      limine = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        maxGenerations = 10;
      };
      efi.canTouchEfiVariables = false;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
