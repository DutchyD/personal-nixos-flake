{ pkgs }:

{
  dotnet-desktop = import ./dotnet-desktop.nix { inherit pkgs; };
}
