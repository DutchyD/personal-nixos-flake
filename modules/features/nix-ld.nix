{ config, lib, ... }:

{
  options.custom.nixLd.enable = lib.mkEnableOption "nix-ld for running dynamically linked binaries not built by Nix";

  config = lib.mkIf config.custom.nixLd.enable {
    programs.nix-ld.enable = true;
  };
}
