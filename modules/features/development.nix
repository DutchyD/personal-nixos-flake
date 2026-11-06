{ config, lib, ... }:

{
  options.custom.development.enable = lib.mkEnableOption "direnv with cached Nix development shells";

  config = lib.mkIf config.custom.development.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
