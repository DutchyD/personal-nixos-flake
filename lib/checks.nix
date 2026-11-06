{
  pkgs,
  nixosConfigurations,
  source,
}:

let
  inherit (pkgs) lib;

  referenceHost = nixosConfigurations.${lib.head (lib.attrNames nixosConfigurations)};

  headlessHost = referenceHost.extendModules {
    modules = [ { custom.desktop = "none"; } ];
  };

  hasPlasma =
    config: config.services.desktopManager.plasma6.enable || config.services.displayManager.sddm.enable;
in
{
  formatting = pkgs.runCommand "formatting" { nativeBuildInputs = [ pkgs.nixfmt ]; } ''
    cd ${source}
    find . -name '*.nix' -exec nixfmt --check {} +
    touch $out
  '';

  plasma-exclusion =
    assert lib.assertMsg (hasPlasma referenceHost.config)
      "Plasma must be enabled when no other desktop is selected";
    assert lib.assertMsg (
      !hasPlasma headlessHost.config
    ) "Plasma must be absent when another desktop is selected";
    pkgs.runCommand "plasma-exclusion" { } "touch $out";
}
