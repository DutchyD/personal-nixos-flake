{ config, lib, ... }:

{
  options.custom.flakePath = lib.mkOption {
    type = lib.types.str;
    default = "${config.users.users.${config.custom.user.name}.home}/Projects/personal-nixos-flake";
    defaultText = lib.literalExpression ''"''${primary user home}/Projects/personal-nixos-flake"'';
    description = "Absolute path of the local checkout of this flake, used as the default flake for nh.";
  };

  config = {
    nix = {
      settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      gc.automatic = false;
      optimise = {
        automatic = true;
        dates = "weekly";
      };
    };

    nixpkgs.config.allowUnfree = true;

    programs.nh = {
      enable = true;
      flake = config.custom.flakePath;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 7d";
      };
    };
  };
}
