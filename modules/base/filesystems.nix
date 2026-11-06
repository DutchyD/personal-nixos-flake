{ lib, ... }:

let
  compressedMountPoints = [
    "/"
    "/home"
    "/nix"
  ];
in
{
  fileSystems = lib.genAttrs compressedMountPoints (_: {
    options = [ "compress=zstd" ];
  });

  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };
}
