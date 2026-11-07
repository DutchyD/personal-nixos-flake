{
  config,
  lib,
  osConfig,
  ...
}:

let
  repoDir = "${config.home.homeDirectory}/Projects/GitHub.com/DutchyD/personal-nixos-flake/home/dutchy";
  link = file: config.lib.file.mkOutOfStoreSymlink "${repoDir}/${file}";
in
{
  config = lib.mkIf (osConfig.custom.desktop == "umbriel") {
    programs.umbriel.enable = true;
    programs.noctalia.enable = true;

    xdg.configFile = {
      "umbriel/config.toml".source = link "umbriel.toml";
      "noctalia/config.toml".source = link "noctalia.toml";
    };
  };
}
